Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 604CA1A18AB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 01:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgDGXhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 19:37:38 -0400
Received: from kernel.crashing.org ([76.164.61.194]:40830 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgDGXhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 19:37:37 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 037Nb5WB017897
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 7 Apr 2020 18:37:08 -0500
Message-ID: <8be4a3c08fce8c47f7d7e42c6d5b6c854a39995c.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 3/4] arch/x86: Optionally flush L1D on context switch
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Kees Cook <keescook@chromium.org>, Balbir Singh <sblbir@amazon.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com, tony.luck@intel.com, x86@kernel.org,
        dave.hansen@intel.com
Date:   Wed, 08 Apr 2020 09:37:04 +1000
In-Reply-To: <202004071125.605F665@keescook>
References: <20200406031946.11815-1-sblbir@amazon.com>
         <20200406031946.11815-4-sblbir@amazon.com> <202004071125.605F665@keescook>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-04-07 at 11:26 -0700, Kees Cook wrote:
> > Add arch specific prctl()'s to opt-in to the L1D cache on context
> > switch
> > out, the existing mechanisms of tracking prev_mm via cpu_tlbstate
> > is
> > reused. cond_ibpb() is refactored and renamed into
> > cond_mitigation().
> 
> I still think this should be a generic prctl(). If there is a strong
> reason not to do this, can it be described in the commit log here?

Agreed.

Cheers,
Ben.


