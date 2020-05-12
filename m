Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7CA21CF5E5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 15:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbgELNed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 09:34:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:40192 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729756AbgELNec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 09:34:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 51B4EAD71;
        Tue, 12 May 2020 13:34:34 +0000 (UTC)
Date:   Tue, 12 May 2020 15:34:29 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Lenny Szubowicz <lszubowi@redhat.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        tglx@linutronix.de, x86@kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: Failure to shutdown/reboot with intel_iommu=on
Message-ID: <20200512133429.GZ8135@suse.de>
References: <20200506144558.GA4019@taurus.defre.kleine-koenig.org>
 <20200508150734.GP8135@suse.de>
 <ff5eb4e2-89a3-57a5-c6d6-42bf743e5d16@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff5eb4e2-89a3-57a5-c6d6-42bf743e5d16@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 09:43:11AM -0400, Lenny Szubowicz wrote:
> I suspect that you have TPM 2.x functionality enabled in the BIOS/firmware.
> 
> Unless you are actually using the TPM, try setting it to TPM 1.2 mode.
> I've seen an incompatiblity on other Lenovo laptops between using the
> IOMMU, TPM 2.x implementation in firmware, and shutdown/suspend.

Interesting, has this been debugged further into the TPM code?


	Joerg
