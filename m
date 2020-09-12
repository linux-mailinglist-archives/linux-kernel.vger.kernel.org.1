Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471F7267CE9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 01:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbgILXUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 19:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgILXU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 19:20:27 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16BCC061574
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 16:20:27 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id d189so13481109oig.12
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 16:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w8MxReSq2289s6KRy6zcF2bLhh+v6ydzvlexh6r8g8o=;
        b=QawhA8g6TBJUmiixWWo4qCuU/qQKXOVOfiNKDxK5T/62TOYC+ETaqPVMcu/SAoCQcn
         xEfTyBNAu5NLrLjEyHjfE4P0pcMP9KgkSqsqavtZtMTgQVFwskoynQM0O3AXkDD8vv4v
         ucvHNzVZyxu8iTafep6sGwAYAJpIETdDUPBgIa2yN5PVDmJwpI8PDEowMizIpUAcV3Fk
         SapcBF6UvFwtHp285i1UYOCUNN5qUpOD9WXptUE9lvayEcfmr3GMQXx/9qYSCVi5uTH1
         SRQ29vNDrBkT4Lo6PUlD+3UB2+s1m2/Cf0KV9mZJMnUm635Nu6PLUcA+miGWehZQN9Ke
         tSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w8MxReSq2289s6KRy6zcF2bLhh+v6ydzvlexh6r8g8o=;
        b=mAb+f+ulHqUc4nptlmWuupUowq91pl1Sj1FfYclc9sP+cvDFHdsGPFc5uIePycUpdb
         st3q6IJbu4lYbhkc88HlqqTH9ddQSUtM5Akk5tkgz4KOvCFo3HmO4ZTvgbR8iFeFZwzk
         qMbiD5kQH5XubfgPvqGDSN29hoeUgbHhZMyhmmwb32D+LV+MkGLYRLoGy0P3Vu5922aN
         2CZksL1Yg/OhmoWgRsLrh2yvKrgjgz/ueIPck4zKyJfkXE10si1cHK48lYycH4mVaegb
         Pv0D1edzuRC4EnnXdoFAs6wx1VSDqEVUI++2U2q/4Rn3tD62AvFuNpI8lYQSSOeEA3tK
         RWKQ==
X-Gm-Message-State: AOAM530gxrFgc7Ck8geIN4l6gkX88b4dUym1GiY52TQK4N4rbQ0J02kr
        6v7OPYGj3Q6n5R5oCapAS5thFw==
X-Google-Smtp-Source: ABdhPJyB3GGG49Y2Ut2ycn9KSHdrrDcRPSymJyoz6FZ0vlWLbNaLYQZ2NidAwHytw8G8JzXCAh5Daw==
X-Received: by 2002:a54:408d:: with SMTP id i13mr4680179oii.156.1599952826913;
        Sat, 12 Sep 2020 16:20:26 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
        by smtp.gmail.com with ESMTPSA id 189sm994100oid.40.2020.09.12.16.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 16:20:26 -0700 (PDT)
Date:   Sat, 12 Sep 2020 18:20:22 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Frank Wunderlich <linux@fw-web.de>,
        John Stultz <john.stultz@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Hanks Chen <hanks.chen@mediatek.com>,
        Andy Gross <agross@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, kernel-team@android.com
Subject: Re: [PATCH 1/6] of: Add basic infrastructure to create early probe
 arrays
Message-ID: <20200912232022.GE3715@yoga>
References: <20200912125148.1271481-1-maz@kernel.org>
 <20200912125148.1271481-2-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200912125148.1271481-2-maz@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 12 Sep 07:51 CDT 2020, Marc Zyngier wrote:

> We currently probe interrupt controller and timers that need
> to be available very early using an infratstructure that creates
> struct of_device_id instances in a special section. These are
> individual structures that are ultimately collated by the linker.
> 
> In order to facilitate further use of this infrastructure for
> drivers that can either be built modular or as an early driver,
> let's add a couple of helpers that will make it look like a
> "normal" device_id array, like this:
> 
> _OF_DECLARE_ARRAY_START(table, name)
> _OF_DECLARE_ELMT("compat-1", probe, type)
> _OF_DECLARE_ELMT("compat-2", probe, type)
> _OF_DECLARE_ELMT("compat-3", other_probe, type)
> _OF_DECLARE_ARRAY_END
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  include/linux/of.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 5cf7ae0465d1..08f78da95378 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -1291,20 +1291,35 @@ static inline int of_get_available_child_count(const struct device_node *np)
>  	return num;
>  }
>  
> +#define __OF_DECLARE_ARRAY_START(name, section)				\
> +	static const struct of_device_id __of_table_##name[]		\
> +		__used __section(section) = {
> +
>  #if defined(CONFIG_OF) && !defined(MODULE)
>  #define _OF_DECLARE(table, name, compat, fn, fn_type)			\
>  	static const struct of_device_id __of_table_##name		\
>  		__used __section(__##table##_of_table)			\
>  		 = { .compatible = compat,				\
>  		     .data = (fn == (fn_type)NULL) ? fn : fn  }
> +#define _OF_DECLARE_ARRAY_START(table, name)				\
> +	__OF_DECLARE_ARRAY_START(name, __##table##_of_table)
>  #else
>  #define _OF_DECLARE(table, name, compat, fn, fn_type)			\
>  	static const struct of_device_id __of_table_##name		\
>  		__attribute__((unused))					\
>  		 = { .compatible = compat,				\
>  		     .data = (fn == (fn_type)NULL) ? fn : fn }
> +#define _OF_DECLARE_ARRAY_START(table, name)				\
> +	__OF_DECLARE_ARRAY_START(name, unused)
>  #endif
>  
> +#define _OF_DECLARE_ARRAY_END	}
> +#define _OF_DECLARE_ELMT(compat, fn, fn_type)				\
> +	{								\
> +		.compatible = compat,					\
> +		.data = (fn == (fn_type)NULL) ? fn : fn,		\
> +	},
> +
>  typedef int (*of_init_fn_2)(struct device_node *, struct device_node *);
>  typedef int (*of_init_fn_1_ret)(struct device_node *);
>  typedef void (*of_init_fn_1)(struct device_node *);
> -- 
> 2.28.0
> 
