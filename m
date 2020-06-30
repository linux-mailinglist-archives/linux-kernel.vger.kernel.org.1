Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B96920F591
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 15:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731804AbgF3NZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 09:25:25 -0400
Received: from foss.arm.com ([217.140.110.172]:50936 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731475AbgF3NZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:25:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7236C1FB;
        Tue, 30 Jun 2020 06:25:17 -0700 (PDT)
Received: from bogus (unknown [10.37.8.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F255E3F71E;
        Tue, 30 Jun 2020 06:25:14 -0700 (PDT)
Date:   Tue, 30 Jun 2020 14:25:12 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Cc:     Francois Ozog <francois.ozog@linaro.org>,
        Jose Marinho <jose.marinho@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, harb@amperecomputing.com,
        Etienne Carriere <etienne.carriere@st.com>
Subject: Re: [PATCH v3] firmware: smccc: Add ARCH_SOC_ID support
Message-ID: <20200630132512.GB4188@bogus>
References: <20200625095939.50861-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625095939.50861-1-sudeep.holla@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Thu, Jun 25, 2020 at 10:59:39AM +0100, Sudeep Holla wrote:
> SMCCC v1.2 adds a new optional function SMCCC_ARCH_SOC_ID to obtain a
> SiP defined SoC identification value. Add support for the same.
> 
> Also using the SoC bus infrastructure, let us expose the platform
> specific SoC atrributes under sysfs.
> 
> There are various ways in which it can be represented in shortened form
> for efficiency and ease of parsing for userspace. The chosen form is
> described in the ABI document.
> 

If you happy with this version, I can send PR for this along with the
clean up series that Greg and others have acked [1]

-- 
Regards,
Sudeep

[1] https://lore.kernel.org/linux-arm-kernel/20200527165238.GA21440@bogus
