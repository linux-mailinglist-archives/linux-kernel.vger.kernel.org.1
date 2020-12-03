Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3522CDC90
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 18:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbgLCRjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 12:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729452AbgLCRjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 12:39:32 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAF6C061A4F;
        Thu,  3 Dec 2020 09:38:52 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id p8so2736656wrx.5;
        Thu, 03 Dec 2020 09:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uYCVp+ROnWAuTHx/WVxuFJUTOv4XtS0u0ecePyghuy4=;
        b=AaRmIrUv35OFpjMGsf+Vfpv6OZQDp+HxUElh99lWrg9+0GH0pStLRhzc05Jz8BfIKh
         PJQiolq6YWSL/oXh3l3SkHpYHHBtppKNHb7eyLJ0qsXl+cFmy6M+T7EzKbRlyFbWH0DK
         Fdsd6kvcKZ4glbX0veXcGNkujfChbduCchBhYQsZ1l1w8fGpa3wTVKeIRHR9j0zhktwK
         mB0HZCUMEitrsItCfu0l7Ul3ONEaKczABvhUGlXSUkrc2IzDsZcJK3XZeDObhqAsRBG0
         TCFX/M9lI+SfpV/LyMlk7KjT8EIlUPtFh083Ty0UdSDkpxEfY9IipAzP/L64WT8WlP6Z
         IhGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uYCVp+ROnWAuTHx/WVxuFJUTOv4XtS0u0ecePyghuy4=;
        b=FT5p7eNtwwyTBezhjoH3Y62XQxF/v+CfDauqUD5rF0nYGsblCTal5FO/UhJYBwGSFi
         7Ii6hCWyo1l82jywV7N8Yy6kcMenvaSGJWycPYF1p9Q/B1wXUCdrpqYlh00qPTf2nif6
         XfdvxyMBJSLU4+KnOOReybRO1YfP1svxH6w9w5jViFDAKO0SbLWjXiB6izmyX+8t/kig
         Fd4CNecR6IyhoxRcoXqe078r9Sq+UHo0xnsTu4zJypX+oWz/8rqRqQJR4rqMiyhg5b6g
         3aAnJmdo1UZl/lfZTA/0lRMg+eZMkVbL51E4Z2avowdXnbSN3V2dZ/iIqyVS0sFnuGla
         wSpg==
X-Gm-Message-State: AOAM5333nMPAKUB4VP6KpAakbZdgekPN5vnAzMVAflOgFKhkFTcJNJb4
        C4WAS8zBkZpVSk3IgQw8414=
X-Google-Smtp-Source: ABdhPJx+aTulitGR17lj3dHbRtrY0MTfpWx8jEnTCSB9Rmp1Ww5fqpILJS8n33+b1fd2Ilzb9URfhQ==
X-Received: by 2002:adf:e850:: with SMTP id d16mr313731wrn.214.1607017131088;
        Thu, 03 Dec 2020 09:38:51 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id s4sm193347wru.56.2020.12.03.09.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 09:38:50 -0800 (PST)
Date:   Thu, 3 Dec 2020 18:38:46 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     herbert@gondor.apana.org.au, mripard@kernel.org, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: crypto: sun4i-ss: error with kmap
Message-ID: <20201203173846.GA16207@Red>
References: <20201201130102.GA23461@Red>
 <87ft4phcyx.fsf@nanos.tec.linutronix.de>
 <20201201135252.GA9584@Red>
 <87y2ihfw6z.fsf@nanos.tec.linutronix.de>
 <20201201144529.GA6786@Red>
 <87v9dlfthf.fsf@nanos.tec.linutronix.de>
 <20201202195501.GA29296@Red>
 <877dpzexfr.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dpzexfr.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 09:59:36PM +0100, Thomas Gleixner wrote:
> On Wed, Dec 02 2020 at 20:55, Corentin Labbe wrote:
> > On Tue, Dec 01, 2020 at 04:15:08PM +0100, Thomas Gleixner wrote:
> >
> > The result could be seen at http://kernel.montjoie.ovh/129768.log
> > The log is 9Mb, but the ftrace dump seems not terminated, tell me if you need more.
> 
> Correct, the interesting entries right before the crash are missing. Can
> you try to make the trace buffers smaller or wait longer before
> terminating the thing?
> 
> 16k buffer size per CPU should be completely sufficient. That should
> give us roughly the last 100 entries per CPU.
> 
> 'trace_buf_size=16k'
> 
> is the command line option for that.
> 

I have set a longer timeout and now the job end with the crash:
http://kernel.montjoie.ovh/130094.log
