Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E8B1D4F93
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 15:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgEONww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 09:52:52 -0400
Received: from foss.arm.com ([217.140.110.172]:56330 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbgEONww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 09:52:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 756DB2F;
        Fri, 15 May 2020 06:52:51 -0700 (PDT)
Received: from bogus (unknown [10.37.12.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E59F63F71E;
        Fri, 15 May 2020 06:52:47 -0700 (PDT)
Date:   Fri, 15 May 2020 14:52:37 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Steven Price <steven.price@arm.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        harb@amperecomputing.com
Subject: Re: [PATCH v3 3/7] firmware: smccc: Add the definition for SMCCCv1.2
 version/error codes
Message-ID: <20200515135237.GA7336@bogus>
References: <20200506164411.3284-1-sudeep.holla@arm.com>
 <20200506164411.3284-4-sudeep.holla@arm.com>
 <20200515113801.GC67718@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200515113801.GC67718@C02TD0UTHF1T.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 12:38:01PM +0100, Mark Rutland wrote:
> On Wed, May 06, 2020 at 05:44:07PM +0100, Sudeep Holla wrote:
> > Add the definition for SMCCC v1.2 version and new error code added.
> > While at it, also add a note that ARM DEN 0070A is deprecated and is
> > now merged into the main SMCCC specification(ARM DEN 0028C).
> > 
> > Reviewed-by: Steven Price <steven.price@arm.com>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> Hmm... the SMCCC v1.2 doc still seems to be EAC rather than a final
> release.
>

Right, I was told final release sometime in the recent past 😄
I mean April or mid-May, I will check on that but yes I agree on your
concerns.

> I don't expect that this would change, but I am a little hesitant to add
> other stuff based on an unfinalized spec. Do we know when the final
> release will be?
>

I have asked for the same as I write this email.

-- 
Regards,
Sudeep
