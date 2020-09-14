Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4741268543
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 09:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgINHCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 03:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgINHCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 03:02:36 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E9AC06174A;
        Mon, 14 Sep 2020 00:02:36 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l9so10059746wme.3;
        Mon, 14 Sep 2020 00:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ml8vr6Wwd8hPNDUkSIjUgKBmst2KUg/iKFfd1eKHbfY=;
        b=Wg/7YIuVODY1f/Qw+IWwdh9GdxY6fqJYt7gJ1WtD7FNB/cQUUSuo9PeYJLawcLQYNO
         H+RN+NNupzvNtEYUw89ad9drszQ5QFVDHe8nUTFzFfBy6AeMM4pT+KCEUfiQZgZE4Jk5
         IWwMZsNCj8UNdcuLFjE1frsuVlM3snQH4h14O+CC1olKiNuvzR7uRUoQbNFcOk3oPm8Q
         gXbN1wpmtYeVZa5Mv+y8z85Ev+3yQC5Tv6awggCOuWV8Y2cocqd4DbFJN06LxwGkZKhv
         ob32wuY9H07TTL6ERgryf/ZlCo/2/BYQ0WA/ljKib6GGoT0AMcB16DHpSDLiufqndw0H
         7F6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ml8vr6Wwd8hPNDUkSIjUgKBmst2KUg/iKFfd1eKHbfY=;
        b=H0zKV1DeS7zpXPWKQ6jgZCiVPU8NGdnCIfk8nhi8K7eesZrMbu5IV4tYUVheyhTiQQ
         y8468S9ydiYp9RXHY/y+N7sdlU9EdD/ktsISJnaACROON1P5P8vLuik0W8Pu+RRjggFy
         5Gd2cmdnM+QBdeTVN8mnQY2sFH2+yBKZHPdcSxGm/vw+AAJDlTk/wOjtIQ/07B+nmUEe
         jJYcPwAp+Nmqu4gPOSCleYhbVw8FM8u4V8xPM7m3yH6DZEgsbqd8SKOowBqc+5pnL1Qe
         HqI8HhYPH4w339IUosu5hbC284TDlYqXkeIcxYqMGeBHGDWkV45RVDo+jKaaYXne8G60
         dp8w==
X-Gm-Message-State: AOAM532+HmZgTtK8/4AGVokVY5as36FcNd818UBVZkvmJVYxx1srfnXw
        UP6bAo1rk/4/eO7Qwucazkg=
X-Google-Smtp-Source: ABdhPJw83MGwijm9vthtmc6HJFUAN1ccQRobbM9harAX3NUVxObqZyzm5N4R+bLvX9UgT+mAbz8KXw==
X-Received: by 2002:a1c:2cc2:: with SMTP id s185mr1769441wms.77.1600066952994;
        Mon, 14 Sep 2020 00:02:32 -0700 (PDT)
Received: from BV030612LT (oi48z9.static.otenet.gr. [79.129.51.141])
        by smtp.gmail.com with ESMTPSA id 185sm19019749wma.18.2020.09.14.00.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 00:02:32 -0700 (PDT)
Date:   Mon, 14 Sep 2020 10:02:27 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        parthiban@linumiz.com, Saravanan Sekar <sravanhome@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org,
        Parthiban Nallathambi <pn@denx.de>
Subject: Re: [PATCH v6 2/3] irqchip: Add Actions Semi Owl SIRQ controller
Message-ID: <20200914070227.GA4491@BV030612LT>
References: <cover.1599552438.git.cristian.ciocaltea@gmail.com>
 <1167b847f6fe1da3834aeaadf5710ddac54f06a0.1599552438.git.cristian.ciocaltea@gmail.com>
 <c5115d27739e1664f808ff5f1fc315e8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5115d27739e1664f808ff5f1fc315e8@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Fri, Sep 11, 2020 at 05:22:41PM +0100, Marc Zyngier wrote:
> On 2020-09-08 09:20, Cristian Ciocaltea wrote:
> > This interrupt controller is found in the Actions Semi Owl SoCs (S500,
> > S700 and S900) and provides support for handling up to 3 external
> > interrupt lines.
> > 
> > Each line can be independently configured as interrupt and triggers on
> > either of the edges or either of the levels. Additionally, each line
> > can also be masked individually.
> > 
> > The patch is based on the work started by Parthiban Nallathambi:
> > https://lore.kernel.org/lkml/20181126100356.2840578-1-pn@denx.de/
> > 
> > Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> > Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> > [cristi: optimized DT, various fixes/cleanups/improvements]
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> 
> Who is the author of these patches? If this is a co-development, please
> use the relevant tags. Otherwise, the author of the patch must come as
> the first SoB.

I took the authorship for the driver patch, as mentioned in the cover
letter. So, if I understand correctly, my SoB should be moved on top and
I assume I also need to drop the related comment line.

> The patch itself looks good.

Thanks for reviewing,
Cristi

> 
>         M.
> -- 
> Jazz is not dead. It just smells funny...
