Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260D4242AF8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 16:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgHLOJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 10:09:59 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:46037 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbgHLOJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 10:09:58 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BRWmh3bJfz5h;
        Wed, 12 Aug 2020 16:09:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1597241396; bh=5Mvf4WwyGgY4xscXSw18sBAkihIor37dh7CZR1yhHRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lssme0HucsSe5wvvURTjfjOKUEN8tkbtr1SLNCW4qgoy9IyM8fDpWAtkGZYrV/FIu
         vLTCpUJgwJCvdcCxGQxmGNZKJSdWbmX5SajDeSMUSC+3nqD2RkbdHZn3d8L9e+hFNf
         4eqt95Z1gcIIgLi/YPa5T1+Z0txggk9zBGvIk24Q13Hsrt926HWIRi+cA62Uc0y0qB
         ysivaT6DKktb0EZNQaE4mlY0GsWlBiY86fJ7vdBVMF4aD0apB71qy6FI789SvhCAxd
         dsVSCHNRVeC6l5gafT1b23Uqjt2pWFx2GNyTix7meUDD5RVa8ZFxfYomWhzjtOfXLF
         PSOLNXOKXWu7Q==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Wed, 12 Aug 2020 16:09:53 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Vladimir Zapolskiy <vz@mleia.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] regulator: plug of_node leak in
 regulator_register()'s error path
Message-ID: <20200812140953.GA11200@qmqm.qmqm.pl>
References: <cover.1597195321.git.mirq-linux@rere.qmqm.pl>
 <f5035b1b4d40745e66bacd571bbbb5e4644d21a1.1597195321.git.mirq-linux@rere.qmqm.pl>
 <cddd3d73-8666-d64b-34f5-d82a3b31cf36@mleia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cddd3d73-8666-d64b-34f5-d82a3b31cf36@mleia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 09:29:12AM +0300, Vladimir Zapolskiy wrote:
> On 8/12/20 4:31 AM, Micha� Miros�aw wrote:
[...]
> >  	config = kmemdup(cfg, sizeof(*cfg), GFP_KERNEL);
> >  	if (config == NULL) {
> > -		kfree(rdev);
> >  		ret = -ENOMEM;
> > -		goto rinse;
> > +		goto clean;
[...]
> >  clean:
> >  	if (dangling_of_gpiod)
> >  		gpiod_put(config->ena_gpiod);
> 
> And above 'config' NULL pointer could be dereferenced now, right?

If config is NULL, dangling_of_gpiod cannot be true.

Best Regards,
Micha� Miros�aw
