Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658A52735A0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 00:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbgIUWTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 18:19:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbgIUWTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 18:19:54 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5604F23A60;
        Mon, 21 Sep 2020 22:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600726794;
        bh=nsVCQXGW+vEBQKem+qf4fpSs9HOCy3YOzLNGU43qo3k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uLC5peuzDtxsOjb6SxAIq4tn6MBy9Awalcr5TWZvRKB0iErsGDoAB/arYYd0TXr2c
         UBSyXWbCqYMy9w0AWL+tjmbuPvNy1Rqx/RSGXpYQXE1v3CSP+XwfNuv70C1xpMrSzj
         UDqAlig4j1FiV8fyguB3wxleiw0Qx04nxP9xMvCQ=
Date:   Mon, 21 Sep 2020 17:19:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     peterz@infradead.org
Cc:     kan.liang@linux.intel.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        eranian@google.com, ak@linux.intel.com
Subject: Re: [RESEND PATCH V2 0/6] Support PCIe3 uncore PMU on Snow Ridge
Message-ID: <20200921221953.GA2139522@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921150631.GS1362448@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 05:06:31PM +0200, peterz@infradead.org wrote:
> On Mon, Sep 14, 2020 at 07:34:14AM -0700, kan.liang@linux.intel.com wrote:
> > From: Kan Liang <kan.liang@linux.intel.com>
> > 
> > Changes since V1:
> > - Drop the platform device solution
> > - A new uncore PCI sub driver solution is introduced which searches
> >   the PCIe Root Port device via pci_get_device() and id table.
> >   Register a PCI bus notifier for the remove notification. Once the
> >   device is removed, the uncore driver can be notified to unregister
> >   the corresponding PMU.
> > - Modify the parameters of uncore_pci_pmu_unregister() function.
> 
> Bjorn, you hated on the last version of this thing, are you OK with this
> one?

Yep, this is OK with me.
