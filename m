Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47BD51BB8E2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 10:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgD1Icr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 04:32:47 -0400
Received: from foss.arm.com ([217.140.110.172]:47692 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbgD1Icr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 04:32:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2B8030E;
        Tue, 28 Apr 2020 01:32:46 -0700 (PDT)
Received: from bogus (unknown [10.37.12.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D48143F305;
        Tue, 28 Apr 2020 01:32:45 -0700 (PDT)
Date:   Tue, 28 Apr 2020 09:32:38 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Richard Gong <richard.gong@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: stratix10-svc: Drop unnecessary checking for
 and populating /firmware/ node
Message-ID: <20200428083238.GA21288@bogus>
References: <20200421173256.34897-1-sudeep.holla@arm.com>
 <8ca3666f-8ff1-3c3c-d40b-81c024b37bdd@linux.intel.com>
 <20200423081149.GB18538@bogus>
 <2b2e29ec-ebbf-3ee6-acc9-3722a2fabbfb@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b2e29ec-ebbf-3ee6-acc9-3722a2fabbfb@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 02:12:56PM -0500, Richard Gong wrote:
> Hi Sudeep,
> 
> In our dts, firmware is not under root node. You can refer to
> arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi for details.
> 
> This is why we need check and populate firmware node.
> 

Ah that's bad. One of very few DTS I see firmware node not in the root.
But this driver is the only one duplicating the code.

-- 
Regards,
Sudeep
