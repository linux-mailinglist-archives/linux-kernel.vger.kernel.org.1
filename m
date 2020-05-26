Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072BF1D745D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 11:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbgERJvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 05:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgERJvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 05:51:15 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA4AC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 02:51:14 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jacQO-0006d5-NZ; Mon, 18 May 2020 11:51:08 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 03561100606; Mon, 18 May 2020 11:51:07 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sasha Levin <sashal@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, luto@kernel.org,
        hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
In-Reply-To: <20200515164013.GF29995@sasha-vm>
References: <20200511045311.4785-1-sashal@kernel.org> <0186c22a8a6be1516df0703c421faaa581041774.camel@linux.intel.com> <20200515164013.GF29995@sasha-vm>
Date:   Mon, 18 May 2020 11:51:07 +0200
Message-ID: <87o8qly3jo.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sasha Levin <sashal@kernel.org> writes:
> On Fri, May 15, 2020 at 12:24:14PM +0300, Jarkko Sakkinen wrote:
>>
>>Can you put me to the CC-loop for this patches. Some SGX-enabled
>>frameworks such as Graphene use out-of-tree changes to achieve this.
>>That's where the interest to possibly test this comes from.
>
> Indeed, we've seen a few hacks that basically just enable FSGSBASE:
>
>  - https://github.com/oscarlab/graphene-sgx-driver
>  - https://github.com/occlum/enable_rdfsbase

I'm really amazed by all these security experts enabling a full root
hole. It clearly puts the SGX hypocrisy into perspective.

Thanks,

        tglx
