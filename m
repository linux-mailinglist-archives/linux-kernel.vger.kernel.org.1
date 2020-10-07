Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199E8285901
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 09:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbgJGHKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 03:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgJGHKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 03:10:32 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9065EC061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 00:10:32 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l11so1170700wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 00:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=u10EPs1jRmK2DZn7K4pF2/ZDCF5F7BT/nktSwnmSKu0=;
        b=ZiuzRn4oq/hDWuqwnBW33C4SbLDHMvyADZkfL51hptFAbi4TFKixcD4Ulp1BDb8SVd
         6RUxo7BYDQTmExBuEjowCJcV4KPfwtMrfclMtIVUWhMqq1JlAQcwULDINa/TT/WWaSpV
         91aptbMpgHu3PKtiZ6hYZEKQMd1b4vhiqGG83x1rI8TQrKv+WmsXsxBw+QMGLnDj3MxI
         Si4PFGgnijHJOrr7kqn6BqC5DeQIeng/8MOvU+txdBl8HC/uESrHsZ42Kj0H6OekG90a
         7Nec2L3tU2nDM+ykG6SQfdJfFfMlkm1jmZp7zsdX2aJf1J7lSuv2223xkR9kFL7f4k0J
         OphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=u10EPs1jRmK2DZn7K4pF2/ZDCF5F7BT/nktSwnmSKu0=;
        b=ADtK1i7xlaDK3eDSc8h7ABE6ZA67d8sRK3AqUXCvIYe2UMgDFLWQMyZGRahlzlS9SP
         ogWViWjzTPuvxvSOTFe2GF3qBGKitkG37XbsQhvsUiPCXzw7s1SzcAxO+Wge7QUtg9M7
         FzP9dFe9j+L4zDQWzkjuDxKsSXa5pWZwsfC0YHr+k1ZZ1jPknFkSi61NdjIf/JNzeoBy
         oAN3evLgek1EnSzQlG5ln6ua64U038VLp5msE6T6+g3rEMjnoZS7M489MbxGXYXw4hOS
         5zy29AXQyVo7wJsilBe1pVnaGZFADtUViBNOooWJIKTsc3MoKHQs3kfclMQccPMuIMS8
         uGhg==
X-Gm-Message-State: AOAM533Q1uFWNrU9bDaIr6lIRSeEK+/3Ga4hun0g8S8vmJ+lwZXDjAuR
        MboQsoQXBs4RMs2SrTevFYQlJQ==
X-Google-Smtp-Source: ABdhPJyWSpbl1r9V3HgqI0X4jxO6eRrdbq4PDbkzLXrTlxLqYutEG4BsO0c98XtfLiG/0Mqcq07/yw==
X-Received: by 2002:a1c:bdc4:: with SMTP id n187mr1756585wmf.185.1602054630985;
        Wed, 07 Oct 2020 00:10:30 -0700 (PDT)
Received: from dell ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id k190sm1370605wme.33.2020.10.07.00.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 00:10:30 -0700 (PDT)
Date:   Wed, 7 Oct 2020 08:10:28 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Michael Brunner <Michael.Brunner@kontron.com>
Cc:     "mibru@gmx.de" <mibru@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: kempld-core: Mark kempld-acpi_table as
 __maybe_unused
Message-ID: <20201007071028.GC1763265@dell>
References: <37c55c13f9042dde06fd67c829b06765286d0580.camel@kontron.com>
 <20201002070134.GR6148@dell>
 <b7fb20174aa7fd8a15132b6de679498fe0b18fd1.camel@kontron.com>
 <20201006065313.GW6148@dell>
 <66d77a96a488078eff1d8f0a2180941d94ce0bdb.camel@kontron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66d77a96a488078eff1d8f0a2180941d94ce0bdb.camel@kontron.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Oct 2020, Michael Brunner wrote:

> On Tue, 2020-10-06 at 07:53 +0100, Lee Jones wrote:
> > On Mon, 05 Oct 2020, Michael Brunner wrote:
> > 
> > > On Fri, 2020-10-02 at 08:01 +0100, Lee Jones wrote:
> > > > On Thu, 01 Oct 2020, Michael Brunner wrote:
> > > > 
> > > > > The Intel 0-DAY CI Kernel Test Service reports an unused variable
> > > > > warning when compiling with clang for PowerPC:
> > > > > 
> > > > > > > drivers/mfd/kempld-core.c:556:36: warning: unused variable
> > > > > > > 'kempld_acpi_table' [-Wunused-const-variable]
> > > > >    static const struct acpi_device_id kempld_acpi_table[] = {
> > > > > 
> > > > > The issue can be fixed by marking kempld_acpi_table as
> > > > > __maybe_unused.
> > > > > 
> > > > > Fixes: e8299c7313af ("[PATCH] mfd: Add ACPI support to Kontron PLD
> > > > > driver")
> > > > > 
> > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > Signed-off-by: Michael Brunner <michael.brunner@kontron.com>
> > > > > ---
> > > > >  drivers/mfd/kempld-core.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/mfd/kempld-core.c b/drivers/mfd/kempld-core.c
> > > > > index 1dfe556df038..273481dfaad4 100644
> > > > > --- a/drivers/mfd/kempld-core.c
> > > > > +++ b/drivers/mfd/kempld-core.c
> > > > > @@ -553,7 +553,7 @@ static int kempld_remove(struct platform_device
> > > > > *pdev)
> > > > >  	return 0;
> > > > >  }
> > > > >  
> > > > > -static const struct acpi_device_id kempld_acpi_table[] = {
> > > > > +static const struct acpi_device_id __maybe_unused
> > > > > kempld_acpi_table[] = {
> > > > >  	{ "KEM0001", (kernel_ulong_t)&kempld_platform_data_generic },
> > > > >  	{}
> > > > >  };
> > > > 
> > > > This is not the right fix.  Better just to compile it out completely
> > > > in these circumstances.  I already have a fix for this in soak.
> > > 
> > > Ok - thank you for the other fix you submitted!
> > > 
> > > But just out of curiosity - in process/coding-style.rst is written that
> > > __maybe_unused should be preferred over wrapping in preprocessor
> > > conditionals, if a function or variable may potentially go unused in a
> > > particular configuration. So why is my patch not the right one here? At
> > > least in my tests it seemed to solve the issue.
> > 
> > It's a bone of contention for sure.  In these kinds of scenarios
> > (i.e. ACPI and OF tables) it is way more common to wrap them:
> > 
> > $ git grep -B3 'acpi_device_id\|of_device_id' | grep 'CONFIG_ACPI\|CONFIG_OF' | wc -l
> > 596
> > $ git grep -B3 'acpi_device_id\|of_device_id' | grep __maybe_unused | wc -l
> > 63
> > 
> > Parsing them out completely, also has the benefit of saving space,
> > reducing the size of the finalised binary.
> 
> Doesn't the compiler remove it anyway? At least in my test I didn't see
> a difference in the resulting object files.
> Doing a crosscheck, by adding __attribute__((used)) to the definition
> of kempld_acpi_table, the object file size increased and
> kempld_acpi_table showed up in the symbol table.
> 
> Nevertheless, I don't want to start a discussion. I am fine with using
> the preprocessor. Just wanted to make sure I understand the technical
> implications of both solutions.

This is what happened last time I submitted a patch using
__maybe_unused:

https://lkml.org/lkml/2020/8/17/1704

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
