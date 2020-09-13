Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43075267D51
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 04:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgIMCkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 22:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbgIMCkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 22:40:40 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998AAC061574
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 19:40:40 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id y25so3206680oog.4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 19:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zOdtPToEcRCUNxG1/0JeqZlo2ECp8NX7tbhb34OB2Hk=;
        b=VpmEpVSkAoTxqp24d1c0u203Y2vihec9/xKibNoGz1R8WBwybmSb1PKcTLWLbhLaCK
         rPSPdmTsJTP7G34gBdwURewqFkys7/8FQrlOZgCv1cu568lTpYOCwVosOYqJgAOQ9xIB
         3468EiRFtcrfYYwOyh3vP2NWJAZKiHWAxESe4TxXjw7+7YBnQL6Lhohrm9g14roMmP32
         JSo5+3SCP8YxMDvf0kzJcK+lvxdL0NY0226Oe3q8pNECoOl0AgLaOMRG7H1WsSRio2Ay
         vrstcS9LbuMC0nfSQhjsbi6vjvXogSDJNkJErdXbsd6aXfye3gtnIanYna35Kevbt6yn
         tYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zOdtPToEcRCUNxG1/0JeqZlo2ECp8NX7tbhb34OB2Hk=;
        b=VG5yf+vMCj+G79s9u54GkheljlDEhKaAD6GUIWUSc7I94IM1PjJvYq91OOG2FN0BQf
         krCsltQFAKs73z+wTToJvWkvSnEBx+ey4XVXnUIM073y55958DUStSdOBoHCTwnVlks7
         4IDEiQ7e3tlomSncExiL2sP1RRQ/iyoO0e22DO4nW4YrDiGliyJMXu56y6Hwx9UHuAjR
         T+VuguPYcpyIffI2u8PGEZoLUV01MoNpqeOZ8oHTEEz6mk3+0QPxRdigyAn8+HpEURHw
         OvRFEGtydbPTOrxMUZfIqtWhDoeNtuHSw52nQXjse6ojV8nBjHu5c0wRh43tveJxGQ8/
         +MXA==
X-Gm-Message-State: AOAM532ikjah1BZIMfG1a1kWTQ8hj1iLJBPjbm5DOLCY0Zz4QF6hK+7s
        cDxYdCUTH0CFM+OMGaGyF5Joyw==
X-Google-Smtp-Source: ABdhPJwJQVrSzau5M9MM0GUZj1xFu0GsYVvrc9zZxcjYLP9XFZOjPb3HJkrw6vsWUydINdr2ZTXE9A==
X-Received: by 2002:a4a:b28a:: with SMTP id k10mr5979768ooo.93.1599964838920;
        Sat, 12 Sep 2020 19:40:38 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
        by smtp.gmail.com with ESMTPSA id a2sm1269332ooo.26.2020.09.12.19.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 19:40:38 -0700 (PDT)
Date:   Sat, 12 Sep 2020 21:40:28 -0500
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
Message-ID: <20200913024028.GO3715@yoga>
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

s/infratstructure/infrastructure/

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
