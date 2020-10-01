Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 797C1280743
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 20:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732384AbgJASxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 14:53:13 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:46713 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729047AbgJASxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 14:53:13 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4C2MhP4nqNz5q;
        Thu,  1 Oct 2020 20:53:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1601578391; bh=zSyouXSzbs9cKzFRJcH0AXftiUn4k6ySHEC5MVl7zyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZUuykW6IKbiwyU/SF5GlOUOqO1doBpgX/6vHlFQ4nRmPZbu2BNy8lC6+J4SPnZdvJ
         YbvCu6Ybs6Hjzce0qc++aSxSxiQ/CVyD5Ngoz826x3bwSE7EP5kQEgYkXZcp6HUY2V
         +pWzrN5r7iS6lvHfUiViZ+njU6M4JDng8Y4IKRq+LJBjwMsCfoVcmxhQmH+lmNMVWg
         d+qo+59JI92JnBjEPGCaJYA4YjppAsEeIqSDHV9b8gOQ7fQEquUIJb3OrekobpkECK
         04fwNJDbkJShaB2nb67QUQxO4x40vtRWazOHqymzJgaWOy5U350ksIsD/Z2xREVlaA
         kl0K/oYeL5zRw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Thu, 1 Oct 2020 20:53:08 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        kuninori.morimoto.gx@renesas.com,
        pierre-louis.bossart@linux.intel.com, perex@perex.cz,
        tiwai@suse.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        sharadg@nvidia.com, mkumard@nvidia.com, viswanathl@nvidia.com,
        rlokhande@nvidia.com, dramesh@nvidia.com, atalambedu@nvidia.com,
        nwartikar@nvidia.com, swarren@nvidia.com, nicoleotsuka@gmail.com
Subject: Re: [PATCH v3 01/13] ASoC: soc-core: Fix component name_prefix
 parsing
Message-ID: <20201001185308.GC23339@qmqm.qmqm.pl>
References: <1601573587-15288-1-git-send-email-spujar@nvidia.com>
 <1601573587-15288-2-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1601573587-15288-2-git-send-email-spujar@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 11:02:55PM +0530, Sameer Pujar wrote:
> The "prefix" can be defined in DAI link node or it can be specified as
> part of the component node itself. Currently "sound-name-prefix" defined
> in a component is not taking effect. Actually the property is not getting
> parsed. It can be fixed by parsing "sound-name-prefix" property whenever
> "prefix" is missing in DAI link Codec node.
[...]
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1124,7 +1124,8 @@ static void soc_set_name_prefix(struct snd_soc_card *card,
>  	for (i = 0; i < card->num_configs; i++) {
>  		struct snd_soc_codec_conf *map = &card->codec_conf[i];
>  
> -		if (snd_soc_is_matching_component(&map->dlc, component)) {
> +		if (snd_soc_is_matching_component(&map->dlc, component) &&
> +		    map->name_prefix) {
>  			component->name_prefix = map->name_prefix;
>  			return;
>  		}

Hi,

It is not obvious how the patch fixes the problem described. I guess now
map->name_prefix is NULL on some level and overrides prefix found earlier?

Best Regards,
Micha³ Miros³aw
