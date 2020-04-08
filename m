Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE741A1DB9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 11:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbgDHJBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 05:01:16 -0400
Received: from foss.arm.com ([217.140.110.172]:35890 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbgDHJBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 05:01:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73DF731B;
        Wed,  8 Apr 2020 02:01:15 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D77F3F73D;
        Wed,  8 Apr 2020 02:01:14 -0700 (PDT)
Date:   Wed, 8 Apr 2020 10:01:12 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Fredrik Strupe <fredrik@strupe.net>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        will.deacon@arm.com
Subject: Re: [PATCH] arm64: armv8_deprecated: Fix undef_hook mask for thumb
 setend
Message-ID: <20200408090111.GA27331@gaia>
References: <911db2f1-e078-a460-32ee-154a0b4de5d4@strupe.net>
 <20200407092744.GA2665@gaia>
 <a2b345a4-30a0-3218-8c8d-e84ec2317dc9@arm.com>
 <0d7b582a-1bd0-9db2-2fdc-04fc887f64c6@strupe.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d7b582a-1bd0-9db2-2fdc-04fc887f64c6@strupe.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 01:18:21PM +0200, Fredrik Strupe wrote:
> (Sorry for duplicate, something went terribly wrong with the formatting of
> the previous email.)

It's still wrong here with tabs converted to spaces. The patch doesn't
apply. Could you please send the patch separately as a v2? It looks fine
otherwise.

Thanks.

-- 
Catalin
