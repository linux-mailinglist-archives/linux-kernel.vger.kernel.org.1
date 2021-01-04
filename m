Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAAE22E9CDE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 19:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbhADSQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 13:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbhADSQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 13:16:33 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241DAC061793
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 10:15:53 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id m5so71115pjv.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 10:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qlJz3MPXf5B/lkmLqteh5JmtegRMOP7WB6D/3515x34=;
        b=uuoXjZHVb0uXZDct2hESQkXhwHbA9dpI/XSWZ858Igyd525ZYlmwjDPQ7k0SaYlV7Z
         feUcuFH+G9i78m8rWHHhfY2FEBNSM8TcEu4CxKw5MKqd6yhQ9RaY+R+h+4fuhORoy7D4
         m5++eqpEmMXymIgT0bSKacUhOrogPhNPCveS8LrnQN2f6OmKapIWAWzsGe6hQIDL6Ix8
         UKfzJLQHgUH48dBNbG9d+8DK+FnBECsG24Y+fmRSsAjm7Lkk29ENprni5nOyGcRURZ/E
         u9tVzcrNEBKDYP9lf2PBZ0eBNKBG98DB3ZhAq8RPD/hCaepCvAMXRz/90cgQXe+wr9gr
         ef5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qlJz3MPXf5B/lkmLqteh5JmtegRMOP7WB6D/3515x34=;
        b=ogPJECSO8lnscI1mMpVFMj9voVNsDSWdlj3pZ7/r3WO0/6bzZ6M25QdUG+ffqOMTTl
         lh1x70UIGnLqkeRILorxtHYp7k1l5BzNXYVv1pZGfQSWEvY97Tcpw0caouii442cvZxN
         LEVQfyouquo0eLiXSKZhc0BnH9+EZVtLIOCapltWar6RBnFlDrahAXK3EUVrp6xSADX8
         Why3LMjAyoxtjfvM9Ye3A5Fn5Osp4WR6B8Zi+ssKeWa0NgjkF17wgqF3eZD5JmXfiOO/
         JCXRDlspjVTrLMO3npEcUVpIP8rVudNINoPrLSPQoyO1Gzvd5ATjFt1PBOd2PKqvmmeW
         iTuw==
X-Gm-Message-State: AOAM533aegl5McpFpnn58llret2J8qbFDLMiZ5C5xiWpcVMwmnVyJ/dH
        s+vhvmbsQ0skc71W6CGUaatN91ORWfzATA==
X-Google-Smtp-Source: ABdhPJyl8A5Klo+A2Isr0dqOyZo3PSp4vR5pTue9lpMDm07o40T1XqxFtPt7Erj2uXAaggWb+FXsUA==
X-Received: by 2002:a17:90a:638a:: with SMTP id f10mr91675pjj.191.1609784152689;
        Mon, 04 Jan 2021 10:15:52 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id cq15sm55902pjb.27.2021.01.04.10.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 10:15:51 -0800 (PST)
Date:   Mon, 4 Jan 2021 11:15:49 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, Mike Leach <mike.leach@linaro.org>,
        Linu Cherian <lcherian@marvell.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 06/11] dts: bindings: Document device tree bindings for
 ETE
Message-ID: <20210104181549.GB2702940@xps15>
References: <1608717823-18387-1-git-send-email-anshuman.khandual@arm.com>
 <1608717823-18387-7-git-send-email-anshuman.khandual@arm.com>
 <20210103170216.GA4048658@robh.at.kernel.org>
 <9d19b169-b037-20b1-7c00-b2ba2194addd@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d19b169-b037-20b1-7c00-b2ba2194addd@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 02:42:08PM +0000, Suzuki K Poulose wrote:
> Hi Rob,
> 
> On 1/3/21 5:02 PM, Rob Herring wrote:
> > On Wed, Dec 23, 2020 at 03:33:38PM +0530, Anshuman Khandual wrote:
> > > From: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > 
> > > Document the device tree bindings for Embedded Trace Extensions.
> > > ETE can be connected to legacy coresight components and thus
> > > could optionally contain a connection graph as described by
> > > the CoreSight bindings.
> > > 
> > > Cc: devicetree@vger.kernel.org
> > > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > Cc: Mike Leach <mike.leach@linaro.org>
> > > Cc: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > > ---
> > >   Documentation/devicetree/bindings/arm/ete.txt | 41 +++++++++++++++++++++++++++
> > >   1 file changed, 41 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/arm/ete.txt
> > 
> > Bindings are in schema format now, please convert this.
> > 
> 
> Sure, will do that.
> 
> > > 
> > > diff --git a/Documentation/devicetree/bindings/arm/ete.txt b/Documentation/devicetree/bindings/arm/ete.txt
> > > new file mode 100644
> > > index 0000000..b52b507
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/arm/ete.txt
> > > @@ -0,0 +1,41 @@
> > > +Arm Embedded Trace Extensions
> > > +
> > > +Arm Embedded Trace Extensions (ETE) is a per CPU trace component that
> > > +allows tracing the CPU execution. It overlaps with the CoreSight ETMv4
> > > +architecture and has extended support for future architecture changes.
> > > +The trace generated by the ETE could be stored via legacy CoreSight
> > > +components (e.g, TMC-ETR) or other means (e.g, using a per CPU buffer
> > > +Arm Trace Buffer Extension (TRBE)). Since the ETE can be connected to
> > > +legacy CoreSight components, a node must be listed per instance, along
> > > +with any optional connection graph as per the coresight bindings.
> > > +See bindings/arm/coresight.txt.
> > > +
> > > +** ETE Required properties:
> > > +
> > > +- compatible : should be one of:
> > > +	"arm,embedded-trace-extensions"
> > > +
> > > +- cpu : the CPU phandle this ETE belongs to.
> > 
> > If this is 1:1 with CPUs, then perhaps it should be a child node of the
> > CPU nodes.
> 
> Yes, it is 1:1 with the CPUs. I have tried to keep this aligned with that of
> "coresight-etm4x". The same driver handles both. The only reason why this
> was separated from the "coresight.txt" is to describe the new configurations
> possible (read, TRBE).

Would it be possible to keep the CPU handle rather than moving things under the
CPU nodes?  ETMv3.x and ETMv4.x are using a handle and as Suzuki points out ETE
and ETMv4.x are sharing the same driver.  Proceeding differently for the ETE
would be terribly confusing.

> 
> That said, I am happy to move this under the CPU, if Mathieu is happy with
> the diversion.
> 
> Thanks for the review.
> 
> Suzuki
