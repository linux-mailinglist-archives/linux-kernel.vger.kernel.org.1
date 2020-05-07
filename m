Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADCD1C965C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 18:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgEGQWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 12:22:30 -0400
Received: from foss.arm.com ([217.140.110.172]:35072 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbgEGQW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 12:22:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0612C101E;
        Thu,  7 May 2020 09:22:29 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 780213F71F;
        Thu,  7 May 2020 09:22:21 -0700 (PDT)
Subject: Re: [PATCH v9 12/18] arm64: kexec: arm64_relocate_new_kernel don't
 use x0 as temp
To:     Pavel Tatashin <pasha.tatashin@soleen.com>, sashal@kernel.org
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
 <20200326032420.27220-13-pasha.tatashin@soleen.com>
From:   James Morse <james.morse@arm.com>
Cc:     jmorris@namei.org, ebiederm@xmission.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        vladimir.murzin@arm.com, matthias.bgg@gmail.com,
        bhsharma@redhat.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com
Message-ID: <04f091b1-692d-c204-8a65-9048fb8b5a5e@arm.com>
Date:   Thu, 7 May 2020 17:22:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200326032420.27220-13-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 26/03/2020 03:24, Pavel Tatashin wrote:
> x0 will contain the only argument to arm64_relocate_new_kernel; don't
> use it as a temp. Reassigned registers to free-up x0.

The missing bit of motivation is _why_ you need x0 keep its value until the end of this code.

With that covered,
Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
