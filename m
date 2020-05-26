Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C991D6B87
	for <lists+linux-kernel@lfdr.de>; Sun, 17 May 2020 19:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgEQRhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 May 2020 13:37:11 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:43113 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgEQRhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 13:37:11 -0400
Received: from localhost (lfbn-lyo-1-1912-bdcst.w90-65.abo.wanadoo.fr [90.65.91.255])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id A176E240003;
        Sun, 17 May 2020 17:37:06 +0000 (UTC)
Date:   Sun, 17 May 2020 19:37:06 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Vaibhav Agarwal <vaibhav.sr@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
        Mark Greer <mgreer@animalcreek.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 5/6] staging: greybus: audio: Add helper APIs for
 dynamic audio modules
Message-ID: <20200517173706.GB34497@piout.net>
References: <cover.1589734179.git.vaibhav.sr@gmail.com>
 <c1339e4d57c8b39bd25197d4514fabd868b829b1.1589734179.git.vaibhav.sr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1339e4d57c8b39bd25197d4514fabd868b829b1.1589734179.git.vaibhav.sr@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 17/05/2020 22:47:20+0530, Vaibhav Agarwal wrote:
> Greybus Codec driver allows modules to be dynamically added and removed,
> which further requires updating the DAPM configurations as well.
> 
> With current snd_soc architecture, dynamic audio modules is not yet
> supported. This patch provides helper APIs to update DAPM configurations
> in response to modules which are dynamically added or removed. The
> source is primarily based on snd_dapm.c
> 

I really think you should send this patch series to the ASoC
maintainers, especially this patch. The main goal shouldn't be to simply
fix compilation issues but to try to get the driver out of staging else,
the current situation will happen again.

> Signed-off-by: Vaibhav Agarwal <vaibhav.sr@gmail.com>
> ---
>  drivers/staging/greybus/Makefile       |   2 +-
>  drivers/staging/greybus/audio_codec.c  |  13 ++-
>  drivers/staging/greybus/audio_helper.c | 197 +++++++++++++++++++++++++++++++++
>  drivers/staging/greybus/audio_helper.h |  17 +++
>  4 files changed, 224 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/staging/greybus/audio_helper.c
>  create mode 100644 drivers/staging/greybus/audio_helper.h
> 
> diff --git a/drivers/staging/greybus/Makefile b/drivers/staging/greybus/Makefile
> index 627e44f2a983..3b4b6cabff19 100644
> --- a/drivers/staging/greybus/Makefile
> +++ b/drivers/staging/greybus/Makefile
> @@ -28,7 +28,7 @@ obj-$(CONFIG_GREYBUS_VIBRATOR)	+= gb-vibrator.o
>  
>  # Greybus Audio is a bunch of modules
>  gb-audio-module-y	:= audio_module.o audio_topology.o
> -gb-audio-codec-y	:= audio_codec.o
> +gb-audio-codec-y	:= audio_codec.o audio_helper.o
>  gb-audio-gb-y		:= audio_gb.o
>  gb-audio-apbridgea-y	:= audio_apbridgea.o
>  gb-audio-manager-y	:= audio_manager.o audio_manager_module.o
> diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
> index bbd072acda5c..866b3342515f 100644
> --- a/drivers/staging/greybus/audio_codec.c
> +++ b/drivers/staging/greybus/audio_codec.c
> @@ -14,6 +14,7 @@
>  #include "audio_codec.h"
>  #include "audio_apbridgea.h"
>  #include "audio_manager.h"
> +#include "audio_helper.h"
>  
>  static struct gbaudio_codec_info *gbcodec;
>  
> @@ -874,7 +875,7 @@ int gbaudio_register_module(struct gbaudio_module_info *module)
>  
>  	/* card already instantiated, create widgets here only */
>  	if (component->card->instantiated) {
> -		snd_soc_dapm_link_component_dai_widgets(component->card,
> +		gbaudio_dapm_link_component_dai_widgets(component->card,
>  							&component->dapm);
>  #ifdef CONFIG_SND_JACK
>  		/*
> @@ -1004,19 +1005,23 @@ void gbaudio_unregister_module(struct gbaudio_module_info *module)
>  	if (module->dapm_routes) {
>  		dev_dbg(component->dev, "Removing %d routes\n",
>  			module->num_dapm_routes);
> +		/* verify routes with controls are removed */
>  		snd_soc_dapm_del_routes(&component->dapm, module->dapm_routes,
>  					module->num_dapm_routes);
>  	}
>  	if (module->controls) {
>  		dev_dbg(component->dev, "Removing %d controls\n",
>  			module->num_controls);
> -		snd_soc_remove_codec_controls(component, module->controls,
> -					      module->num_controls);
> +		/* release control semaphore */
> +		up_write(&card->controls_rwsem);
> +		gbaudio_remove_component_controls(component, module->controls,
> +						  module->num_controls);
> +		down_write(&card->controls_rwsem);
>  	}
>  	if (module->dapm_widgets) {
>  		dev_dbg(component->dev, "Removing %d widgets\n",
>  			module->num_dapm_widgets);
> -		snd_soc_dapm_free_controls(&component->dapm,
> +		gbaudio_dapm_free_controls(&component->dapm,
>  					   module->dapm_widgets,
>  					   module->num_dapm_widgets);
>  	}
> diff --git a/drivers/staging/greybus/audio_helper.c b/drivers/staging/greybus/audio_helper.c
> new file mode 100644
> index 000000000000..e2f113a811ee
> --- /dev/null
> +++ b/drivers/staging/greybus/audio_helper.c
> @@ -0,0 +1,197 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Greybus Audio Sound SoC helper APIs
> + */
> +
> +#include <linux/debugfs.h>
> +#include <sound/core.h>
> +#include <sound/soc.h>
> +#include <sound/soc-dapm.h>
> +
> +#define gbaudio_dapm_for_each_direction(dir) \
> +	for ((dir) = SND_SOC_DAPM_DIR_IN; (dir) <= SND_SOC_DAPM_DIR_OUT; \
> +		(dir)++)
> +
> +static void gbaudio_dapm_link_dai_widget(struct snd_soc_dapm_widget *dai_w,
> +					 struct snd_soc_card *card)
> +{
> +	struct snd_soc_dapm_widget *w;
> +	struct snd_soc_dapm_widget *src, *sink;
> +	struct snd_soc_dai *dai = dai_w->priv;
> +
> +	/* ...find all widgets with the same stream and link them */
> +	list_for_each_entry(w, &card->widgets, list) {
> +		if (w->dapm != dai_w->dapm)
> +			continue;
> +
> +		switch (w->id) {
> +		case snd_soc_dapm_dai_in:
> +		case snd_soc_dapm_dai_out:
> +			continue;
> +		default:
> +			break;
> +		}
> +
> +		if (!w->sname || !strstr(w->sname, dai_w->sname))
> +			continue;
> +
> +		/*
> +		 * check if widget is already linked,
> +		 * if (w->linked)
> +		 *	return;
> +		 */
> +
> +		if (dai_w->id == snd_soc_dapm_dai_in) {
> +			src = dai_w;
> +			sink = w;
> +		} else {
> +			src = w;
> +			sink = dai_w;
> +		}
> +		dev_dbg(dai->dev, "%s -> %s\n", src->name, sink->name);
> +		/* Add the DAPM path and set widget's linked status
> +		 * snd_soc_dapm_add_path(w->dapm, src, sink, NULL, NULL);
> +		 * w->linked = 1;
> +		 */
> +	}
> +}
> +
> +int gbaudio_dapm_link_component_dai_widgets(struct snd_soc_card *card,
> +					    struct snd_soc_dapm_context *dapm)
> +{
> +	struct snd_soc_dapm_widget *dai_w;
> +
> +	/* For each DAI widget... */
> +	list_for_each_entry(dai_w, &card->widgets, list) {
> +		if (dai_w->dapm != dapm)
> +			continue;
> +		switch (dai_w->id) {
> +		case snd_soc_dapm_dai_in:
> +		case snd_soc_dapm_dai_out:
> +			break;
> +		default:
> +			continue;
> +		}
> +		gbaudio_dapm_link_dai_widget(dai_w, card);
> +	}
> +
> +	return 0;
> +}
> +
> +static void gbaudio_dapm_free_path(struct snd_soc_dapm_path *path)
> +{
> +	list_del(&path->list_node[SND_SOC_DAPM_DIR_IN]);
> +	list_del(&path->list_node[SND_SOC_DAPM_DIR_OUT]);
> +	list_del(&path->list_kcontrol);
> +	list_del(&path->list);
> +	kfree(path);
> +}
> +
> +static void gbaudio_dapm_free_widget(struct snd_soc_dapm_widget *w)
> +{
> +	struct snd_soc_dapm_path *p, *next_p;
> +	enum snd_soc_dapm_direction dir;
> +
> +	list_del(&w->list);
> +	/*
> +	 * remove source and sink paths associated to this widget.
> +	 * While removing the path, remove reference to it from both
> +	 * source and sink widgets so that path is removed only once.
> +	 */
> +	gbaudio_dapm_for_each_direction(dir) {
> +		snd_soc_dapm_widget_for_each_path_safe(w, dir, p, next_p)
> +			gbaudio_dapm_free_path(p);
> +	}
> +
> +	kfree(w->kcontrols);
> +	kfree_const(w->name);
> +	kfree_const(w->sname);
> +	kfree(w);
> +}
> +
> +int gbaudio_dapm_free_controls(struct snd_soc_dapm_context *dapm,
> +			       const struct snd_soc_dapm_widget *widget,
> +			       int num)
> +{
> +	int i;
> +	struct snd_soc_dapm_widget *w, *next_w;
> +#ifdef CONFIG_DEBUG_FS
> +	struct dentry *parent = dapm->debugfs_dapm;
> +	struct dentry *debugfs_w = NULL;
> +#endif
> +
> +	mutex_lock(&dapm->card->dapm_mutex);
> +	for (i = 0; i < num; i++) {
> +		/* below logic can be optimized to identify widget pointer */
> +		list_for_each_entry_safe(w, next_w, &dapm->card->widgets,
> +					 list) {
> +			if (w->dapm != dapm)
> +				continue;
> +			if (!strcmp(w->name, widget->name))
> +				break;
> +			w = NULL;
> +		}
> +		if (!w) {
> +			dev_err(dapm->dev, "%s: widget not found\n",
> +				widget->name);
> +			return -EINVAL;
> +		}
> +		widget++;
> +#ifdef CONFIG_DEBUG_FS
> +		if (!parent)
> +			debugfs_w = debugfs_lookup(w->name, parent);
> +		debugfs_remove(debugfs_w);
> +		debugfs_w = NULL;
> +#endif
> +		gbaudio_dapm_free_widget(w);
> +	}
> +	mutex_unlock(&dapm->card->dapm_mutex);
> +	return 0;
> +}
> +
> +static int gbaudio_remove_controls(struct snd_card *card, struct device *dev,
> +				   const struct snd_kcontrol_new *controls,
> +				   int num_controls, const char *prefix)
> +{
> +	int i, err;
> +
> +	for (i = 0; i < num_controls; i++) {
> +		const struct snd_kcontrol_new *control = &controls[i];
> +		struct snd_ctl_elem_id id;
> +		struct snd_kcontrol *kctl;
> +
> +		if (prefix)
> +			snprintf(id.name, sizeof(id.name), "%s %s", prefix,
> +				 control->name);
> +		else
> +			strlcpy(id.name, control->name, sizeof(id.name));
> +		id.numid = 0;
> +		id.iface = control->iface;
> +		id.device = control->device;
> +		id.subdevice = control->subdevice;
> +		id.index = control->index;
> +		kctl = snd_ctl_find_id(card, &id);
> +		if (!kctl) {
> +			dev_err(dev, "%d: Failed to find %s\n", err,
> +				control->name);
> +			return -ENOENT;
> +		}
> +		err = snd_ctl_remove(card, kctl);
> +		if (err < 0) {
> +			dev_err(dev, "%d: Failed to remove %s\n", err,
> +				control->name);
> +			return err;
> +		}
> +	}
> +	return 0;
> +}
> +
> +int gbaudio_remove_component_controls(struct snd_soc_component *component,
> +				      const struct snd_kcontrol_new *controls,
> +				      unsigned int num_controls)
> +{
> +	struct snd_card *card = component->card->snd_card;
> +
> +	return gbaudio_remove_controls(card, component->dev, controls,
> +				       num_controls, component->name_prefix);
> +}
> diff --git a/drivers/staging/greybus/audio_helper.h b/drivers/staging/greybus/audio_helper.h
> new file mode 100644
> index 000000000000..5cf1c6d7d3ea
> --- /dev/null
> +++ b/drivers/staging/greybus/audio_helper.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Greybus Audio Sound SoC helper APIs
> + */
> +
> +#ifndef __LINUX_GBAUDIO_HELPER_H
> +#define __LINUX_GBAUDIO_HELPER_H
> +
> +int gbaudio_dapm_link_component_dai_widgets(struct snd_soc_card *card,
> +					    struct snd_soc_dapm_context *dapm);
> +int gbaudio_dapm_free_controls(struct snd_soc_dapm_context *dapm,
> +			       const struct snd_soc_dapm_widget *widget,
> +			       int num);
> +int gbaudio_remove_component_controls(struct snd_soc_component *component,
> +				      const struct snd_kcontrol_new *controls,
> +				      unsigned int num_controls);
> +#endif
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
