Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209D02BC536
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 12:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgKVK70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 05:59:26 -0500
Received: from mail-ej1-f68.google.com ([209.85.218.68]:44887 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbgKVK7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 05:59:25 -0500
Received: by mail-ej1-f68.google.com with SMTP id k9so4419255ejc.11
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 02:59:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kEmJgdOt9epBAyBXuoK443XqdXUwSvrAQGvWlpK7B60=;
        b=nSBD8Uj9OI51zGdzb1C6JFQT4PxrJ9ulHB7Q++Yf8KOq7IvNzP5ltQLdp4yV6AXK7g
         2hC8YMPi9TUTMnZV2km/jRhoCwOXiidazFwUsVDSRU4UeGyXAYyyAdO8p4QJVwNOM99d
         55+unO6hlINGmKEy6lEtTMnfVZp1KIYoG+pUrLCbRhwcGGc6Ep+4ugPaodIfOH1amDrc
         ZufQ8XTnSraTMnWEylT+gPutVo6AdbL0zDHKkxRdsQ5dXMbYIsHk6Z9qR7Yx+0yzPQG+
         pX543B8+RUicommJqGX6U4X+hYbis9zPvU2UOfEegnB5Hfq2dGPloGPqyvGvz+OuxYf5
         dS+g==
X-Gm-Message-State: AOAM531tQOb8wa620RPyG9G1RcTdgaAiBphw62tJZtDIgQhkrZwZ3uYG
        MTMGL9iyq9SUahpMg36a9BA=
X-Google-Smtp-Source: ABdhPJx9/at7TqslKqBC1FttD6Qn1HkD8A1lfWiRV3W7aMzo2tQ1gL48uK3RYrJDXbzJbIaGcfMtow==
X-Received: by 2002:a17:906:b783:: with SMTP id dt3mr39218452ejb.534.1606042763050;
        Sun, 22 Nov 2020 02:59:23 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id p25sm994520eju.63.2020.11.22.02.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 02:59:21 -0800 (PST)
Date:   Sun, 22 Nov 2020 11:59:20 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH 01/38] ASoC: ak5558: drop of_match_ptr from of_device_id
 table
Message-ID: <20201122105813.GA3780@kozik-lap>
References: <20201120161653.445521-1-krzk@kernel.org>
 <20201120165202.GG6751@sirena.org.uk>
 <20201120194245.GA2925@kozik-lap>
 <20201120200429.GJ6751@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201120200429.GJ6751@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 08:04:29PM +0000, Mark Brown wrote:
> On Fri, Nov 20, 2020 at 08:42:45PM +0100, Krzysztof Kozlowski wrote:
> > On Fri, Nov 20, 2020 at 04:56:34PM +0000, Mark Brown wrote:
> 
> > > It would be better to fix these by annotating the table as potentially
> > > unused, if nothing else it means if someone wants to add ACPI support
> > > (or it just works on their ACPI system with the plain old I2C ID) then
> > > they don't need to revert this change.
> 
> > The point is after this patch - removal of of_match_ptr() - they will
> > already support the ACPI matching through the PRP0001.
> 
> > Keeping of_match_ptr() and maybe_unused will prevent any ACPI re-usage
> > unless explicit ACPI table is added
> 
> Surely if that's the desired outcome the fix is to change the definition
> of of_match_ptr() such that it leaves the reference with CONFIG_ACPI,
> perhaps hidden behind a config option for PRP0001?  That seems better
> than going through the entire tree like this.

That could be indeed an easier way to achieve this.

+Cc Andy, Rafael,

I saw you were doing similar way as I did here [1] for the 698fffc2705c
("rtc: ds1307: Drop of_match_ptr and CONFIG_OF protections") with the
same reasoning as mine ("These prevent use of this driver with ACPI via
PRP0001.").

Do you have thoughts on Mark's proposal above (to change the
of_match_ptr())?

[1] https://lore.kernel.org/lkml/20201120161653.445521-1-krzk@kernel.org/

Best regards,
Krzysztof

