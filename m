Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 434E3286A6D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 23:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgJGVqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 17:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgJGVqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 17:46:38 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F05EC061755;
        Wed,  7 Oct 2020 14:46:37 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id s17so2035045qvr.11;
        Wed, 07 Oct 2020 14:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YqNUjigFoAXo2QafX/TTeVVXBpaXL3Be2L3u2zpujGM=;
        b=nOiCFVqKn9qpKVGgPb0MgXhOqUoxudL61nKQkOjg6IWYyDk7Mo60sg2BiYT+qgKZvC
         9VaQkgDLA3ZFv1YeeJC8BhF9M8X0SCrRrSiTt+2qetxnyXbH6atyoKgXDCG+UE40ZIzZ
         86eXvROXYmV9sEIjqxwP/Q0MBgczL3xkhw3tZ7MCJgP+byDpqTsBY2BbJSpPN9Wz1b9k
         cH5Ixg1DSgILYeRCDfE7unh/IUxVWkV3xpA7GsvrNGL/W/WZFUh6bZOOue7NP1YXbeOy
         HjjcZn6gKV+UzkojRivqPU3griS6IdQl+o2V6nUDg6cBBz2ClbxBjZtP7r4dqtDaoib7
         +OYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YqNUjigFoAXo2QafX/TTeVVXBpaXL3Be2L3u2zpujGM=;
        b=FQ+JYpniK+pB4t68Oatylat+/PJqBkqpWPR8TjYXt8gDLVV3FwxQan4gGD08uA+dqb
         uCLPvXaci4iO9stXWxCsvv23MJ9WG1CUfSWLy6wRL4ctZqnPXzCoVviUR2iaoRrhZNj+
         ulYg7KTkgRbjpFXfAqkevfwHw9urHNK5/CQ2tGFxiUYhJE1kXKqeSP4JNp7E2vbZAago
         /zMZNTEe1OTVPWihWXqfy3BOvlMK8PwfA5DJ4YVl32K8+jAxfYWSiG48XrIr01UnPFbQ
         GnobJJtpi7jDEh6YuFJgHnmcRtseyxJ3f+n03zM299TdkJQb1lCyDq8hUjetaEgGPEDD
         Kgww==
X-Gm-Message-State: AOAM531vImpIsZzQP+A6N/wQz4a5/yWb4H7ohKJArlPnslJhq1lEz0/p
        Awj32VnE3E61SctD11hdcINKQd5q2IB9XA==
X-Google-Smtp-Source: ABdhPJzrDqRTfzp3kraZFbds/BuMxeQZZRTCB5lCKd7Q3veIzOCHzA9lsDBscGJUHmrCwPpXm8IlwQ==
X-Received: by 2002:a0c:c492:: with SMTP id u18mr5342732qvi.18.1602107196335;
        Wed, 07 Oct 2020 14:46:36 -0700 (PDT)
Received: from ubuntu (ool-45785633.dyn.optonline.net. [69.120.86.51])
        by smtp.gmail.com with ESMTPSA id 128sm2408554qkm.76.2020.10.07.14.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 14:46:35 -0700 (PDT)
Date:   Wed, 7 Oct 2020 17:46:33 -0400
From:   Vivek Unune <npcomplete13@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     devicetree@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] ARM: dts: BCM5301X: Linksys EA9500 make use of
 pinctrl
Message-ID: <20201007214633.GA1972@ubuntu>
References: <cover.1601655904.git.npcomplete13@gmail.com>
 <6687de05226dd055ee362933d4841a12b038792d.1601655904.git.npcomplete13@gmail.com>
 <20201007210134.GD112961@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007210134.GD112961@lunn.ch>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 11:01:34PM +0200, Andrew Lunn wrote:
> On Wed, Oct 07, 2020 at 03:01:50PM -0400, Vivek Unune wrote:
> > Forgo the use of mmioreg mdio mux infavor of the pinctrl
> 
> Hi Vivek
> 
> Could you add some more details please. I don't know this
> hardware. I'm assuming there are two MDIO busses, external as talked
> about in the comments, and an internal one? And for this hardware you
> only need one of them? But i don't see what pinmux has to do with
> this?
Hi Andrew,

There are indeed two mdio busses. To access the external bus, 9th bit
of the mdio register has to be set. And to enable mii function,
one has to set the registers 6 & 7 which is part of the pin controller.
Earlier the pin controller was not defined and I resorted to use a
combination of memory mapped io mux to change desired bits.

Now that we have a pin controller - which is resposnsible for other 
functionality such as pwm, i2c, uart2, it makes sense to have a consistent
device tree

Hope this helps,

Vivek


> 
> Thanks
> 	Andrew
>  
