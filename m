Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A7D276F65
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 13:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbgIXLI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 07:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgIXLI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 07:08:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322D2C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 04:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=O0EJgRily1jYuumgPBHPhqUWkE5i4TarKWnniu78rFU=; b=pgFEh7sHPx14Bnf8/HGJN3669q
        qHopX+w7O354Ynv1fJ+wLHk3JrFUoF5s3bVYhDwBXdrLGsQtbkE2dcaaVfVoV+7RT/tTTZvEE7Odb
        SJhhEU2rV4eY2R/rE8vflXOJVLPYgQ8QGFsJ08LZ9a52PeYgOOhMQuiVbK3rHHpqiXeawck+ezm9a
        7xWLpt3bbiMaf8F3HhGiu3FAWH33A5u8NuXs838mahdTp8+DJuVAuV2F2clUIcXresvw2BeX5oerJ
        UZPnEAN34dPQadSmDcXebyzOucDaLTkg2Xn5lVH+OB9E58rXsoIEg1m3da/cF9hKrgwff0VgkJrq4
        id0Nf94w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLP6o-0000Jm-Iw; Thu, 24 Sep 2020 11:08:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E52A3306E6D;
        Thu, 24 Sep 2020 13:08:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D0D9A202099B7; Thu, 24 Sep 2020 13:08:17 +0200 (CEST)
Date:   Thu, 24 Sep 2020 13:08:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     kan.liang@linux.intel.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        eranian@google.com, ak@linux.intel.com
Subject: Re: [RESEND PATCH V2 0/6] Support PCIe3 uncore PMU on Snow Ridge
Message-ID: <20200924110817.GC2628@hirez.programming.kicks-ass.net>
References: <20200921150631.GS1362448@hirez.programming.kicks-ass.net>
 <20200921221953.GA2139522@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921221953.GA2139522@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 05:19:53PM -0500, Bjorn Helgaas wrote:
> On Mon, Sep 21, 2020 at 05:06:31PM +0200, peterz@infradead.org wrote:
> > On Mon, Sep 14, 2020 at 07:34:14AM -0700, kan.liang@linux.intel.com wrote:
> > > From: Kan Liang <kan.liang@linux.intel.com>
> > > 
> > > Changes since V1:
> > > - Drop the platform device solution
> > > - A new uncore PCI sub driver solution is introduced which searches
> > >   the PCIe Root Port device via pci_get_device() and id table.
> > >   Register a PCI bus notifier for the remove notification. Once the
> > >   device is removed, the uncore driver can be notified to unregister
> > >   the corresponding PMU.
> > > - Modify the parameters of uncore_pci_pmu_unregister() function.
> > 
> > Bjorn, you hated on the last version of this thing, are you OK with this
> > one?
> 
> Yep, this is OK with me.

Thanks!
