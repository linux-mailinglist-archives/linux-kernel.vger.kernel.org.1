Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A222FBDD9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 18:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391599AbhASRhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 12:37:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:54984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391627AbhASPv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 10:51:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1444920780;
        Tue, 19 Jan 2021 15:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611071448;
        bh=5Kypprw0IOBfKAIc7GzQhyjIWmL2TNunxnPA/dyuLjY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QMYzr3yEBhLTvzRMvcGQERKFgF3okrKank5UBAITfrSC1yaR7WK2Kj3fQl6daqxNg
         KUXi0sjhaZeFw0AEP78rJ+FKoafXWZCZ3epvMnmuvsQV2N79LMWXD9yXMWo4UN6F/W
         JFKgTvb5tCwwdQrmP9bgHWWjISIz2lieLq5ak7QSRBt1u/lDkpRS3YGOYZ4MuvLoCj
         idU5J7/y/wG4F7EBvZhcGZLz4f9EED+DgGoivpYoZpgWGAyQAm7zp4KQaTqz+qXjVP
         GR9vVmExiDjX7QQWQjPppaF1r2/h7PZ6yAD0W8NMm0Q7J3ZPxTtxegE1XzFLXavtXR
         bnSdfIB+Vkubg==
Date:   Tue, 19 Jan 2021 16:50:43 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mayulong <mayulong1@huawei.com>,
        Rob Herring <robh+dt@kernel.org>, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 15/18] mfd: hi6421-spmi-pmic: move driver from
 staging
Message-ID: <20210119165043.799daa80@coco.lan>
In-Reply-To: <20210119134622.GB4478@sirena.org.uk>
References: <cover.1611048785.git.mchehab+huawei@kernel.org>
        <aa17f0fee8cfcd654e107897d350cb3b0438763b.1611048785.git.mchehab+huawei@kernel.org>
        <20210119134622.GB4478@sirena.org.uk>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 19 Jan 2021 13:46:22 +0000
Mark Brown <broonie@kernel.org> escreveu:

> On Tue, Jan 19, 2021 at 11:14:20AM +0100, Mauro Carvalho Chehab wrote:
> 
> > +int hi6421_spmi_pmic_read(struct hi6421_spmi_pmic *pmic, int reg)
> > +{
> > +	struct spmi_device *pdev;
> > +	u8 read_value = 0;
> > +	u32 ret;
> > +
> > +	pdev = to_spmi_device(pmic->dev);
> > +	if (!pdev) {
> > +		pr_err("%s: pdev get failed!\n", __func__);
> > +		return -ENODEV;
> > +	}
> > +
> > +	ret = spmi_ext_register_readl(pdev, reg, &read_value, 1);
> > +	if (ret) {
> > +		pr_err("%s: spmi_ext_register_readl failed!\n", __func__);
> > +		return ret;
> > +	}
> > +	return read_value;
> > +}
> > +EXPORT_SYMBOL(hi6421_spmi_pmic_read);  
> 
> The I/O here looks a lot like regmap_spmi_ext.

Did a test here converting it to use regmap. It worked.

I'm sending a (hopefully) final patchset.

Regards,
Mauro
