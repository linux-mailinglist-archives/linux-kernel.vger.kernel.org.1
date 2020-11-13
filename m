Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9292B189E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 10:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgKMJrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 04:47:47 -0500
Received: from foss.arm.com ([217.140.110.172]:35286 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgKMJrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 04:47:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42A621042;
        Fri, 13 Nov 2020 01:47:36 -0800 (PST)
Received: from bogus (unknown [10.57.15.107])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50E193F6CF;
        Fri, 13 Nov 2020 01:47:35 -0800 (PST)
Date:   Fri, 13 Nov 2020 09:47:32 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] firmware: arm_scmi: Augment SMC/HVC to allow
 optional interrupt
Message-ID: <20201113094732.4bcyjs7zz7vwg4of@bogus>
References: <20201112175632.42234-1-james.quinlan@broadcom.com>
 <20201112175632.42234-3-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112175632.42234-3-james.quinlan@broadcom.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 12:56:27PM -0500, Jim Quinlan wrote:
> The SMC/HVC SCMI transport is modified to allow the completion of an SCMI
> message to be indicated by an interrupt rather than the return of the smc
> call.  This accommodates the existing behavior of the BrcmSTB SCMI
> "platform" whose SW is already out in the field and cannot be changed.
>

Sorry for missing to check with you earlier. Are these not fast smc calls ?
Can we check the SMC Function IDs for the same and expect IRQ to be present
if they are not fast calls ?

-- 
Regards,
Sudeep
