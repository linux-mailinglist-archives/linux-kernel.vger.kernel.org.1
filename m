Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16AFB27359F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 00:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgIUWTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 18:19:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbgIUWT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 18:19:28 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DAB023A60;
        Mon, 21 Sep 2020 22:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600726768;
        bh=arP0lyzu4ZP/6mZ5c6gn2TtbkaQYFXh2JDWGCkkM1Z4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=I71bsQd4xUaSenCEFrTi1KQAgr4DeQH3o2l9h81itnHntUyjtuXsdvIDN0PGWqZwM
         6QIfYT7/8gaYdHZVz4X9xjK2MKQKABeNYUEKxGsycz09YV1hubksdlpiAxXMQ7Qb2U
         5U/we8goerqSpQv27d3Sp8MgLTIlUZoIPXmUQ0gU=
Date:   Mon, 21 Sep 2020 17:19:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        eranian@google.com, ak@linux.intel.com
Subject: Re: [RESEND PATCH V2 5/6] perf/x86/intel/uncore: Generic support for
 the PCI sub driver
Message-ID: <20200921221926.GA2139384@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600094060-82746-6-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 07:34:19AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Some uncore counters may be located in the configuration space of a PCI
> device, which already has a bonded driver. Currently, the uncore driver
> cannot register a PCI uncore PMU for these counters, because, to
> register a PCI uncore PMU, the uncore driver must be bond to the device.
> However, one device can only have one bonded driver.
> 
> Add an uncore PCI sub driver to support such kind of devices.
> 
> The sub driver doesn't own the device. In initialization, the sub
> driver searches the device via pci_get_device(), and register the
> corresponding PMU for the device. In the meantime, the sub driver
> registeris a PCI bus notifier, which is used to notify the sub driver
> once the device is removed. The sub driver can unregister the PMU
> accordingly.

s/registeris/registers/

It looks like this only handles hot-remove of the device, not hot-add.
Maybe that's OK for your use case, I dunno, so just pointing it out.
