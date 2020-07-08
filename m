Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F912191B0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 22:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbgGHUk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 16:40:57 -0400
Received: from foss.arm.com ([217.140.110.172]:36720 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgGHUk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 16:40:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 897E81FB;
        Wed,  8 Jul 2020 13:40:56 -0700 (PDT)
Received: from bogus (unknown [10.37.8.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C8A23F887;
        Wed,  8 Jul 2020 13:40:52 -0700 (PDT)
Date:   Wed, 8 Jul 2020 21:40:49 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Paul Murphy <paul.j.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/7] dt-bindings: mailbox: Add Keem Bay SCMI mailbox
 bindings
Message-ID: <20200708204049.GD31671@bogus>
References: <20200616155613.121242-1-daniele.alessandrelli@linux.intel.com>
 <20200616155613.121242-2-daniele.alessandrelli@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616155613.121242-2-daniele.alessandrelli@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 04:56:07PM +0100, Daniele Alessandrelli wrote:
> From: Paul Murphy <paul.j.murphy@intel.com>
> 
> These are the bindings required for the Intel Keem Bay SCMI mailbox
> driver.
> 

Redundant binding, just use existing SMC SCMI transport binding for this
and the driver.

-- 
Regards,
Sudeep
