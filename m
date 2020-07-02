Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F2B212FF9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 01:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgGBXYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 19:24:13 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:44850 "EHLO
        esa4.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgGBXYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 19:24:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1593732252;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=DD/40Qz8qZ78c4jky0R8eJwe8SV5DGFlqxwDiyq60pw=;
  b=dSkUvgeHtKGv8ckYivVY5J7d7/bFXIX60d6R2n8P14Cg/5guSF2fcJIN
   ayhG79qAW3QIAAHZ46z3oHU0wdFYBLZQwEuIFeeu7/nNwGgFDU1nvzrlu
   PiXF94l4++psFputDy+FfWtXcocL4FwJMNRallnLRMYV+uJ5qr5v939pE
   o=;
Authentication-Results: esa4.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: EHdLL4zhLW9bpSAxAYvRa35rsjy9utSWkFNwQ8GKYJ+LgLEnAwpznR4lbdlktDiJaHK1o4M5lZ
 S9HVefjH7PkelGMqcFH6RJL0JqHfpf9IcxUSI8VAQovcbJluYYMeF1D8rqexJXsykDNol2W6J9
 zkUhu+rXVjkd5mxogyU8jPVFs0w0NNcM6Mrh4UdjXGLcHhpaa7BnEGf9ra8xsTjZKldT9NTuNF
 qTi/2UdOord7K58h1mQXpcGPw8obNGNY7+e1hE0eYiOjt5TnUJpkspi3E+mRNaXVAAtuQJ4Dr7
 fRM=
X-SBRS: 2.7
X-MesageID: 22346397
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.75,305,1589256000"; 
   d="scan'208";a="22346397"
Subject: Re: [PATCH v2 1/4] x86/xen: remove 32-bit Xen PV guest support
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        <xen-devel@lists.xenproject.org>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Stefano Stabellini <sstabellini@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200701110650.16172-1-jgross@suse.com>
 <20200701110650.16172-2-jgross@suse.com>
 <6d0b517a-6c53-61d3-117b-40e33e013037@oracle.com>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <9f8cc440-82f0-d6d8-945d-19c48f69a6b0@citrix.com>
Date:   Fri, 3 Jul 2020 00:24:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <6d0b517a-6c53-61d3-117b-40e33e013037@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/07/2020 23:59, Boris Ostrovsky wrote:
> On 7/1/20 7:06 AM, Juergen Gross wrote:
>>  
>> -#ifdef CONFIG_X86_PAE
>> -static void xen_set_pte_atomic(pte_t *ptep, pte_t pte)
>> -{
>> -	trace_xen_mmu_set_pte_atomic(ptep, pte);
>> -	__xen_set_pte(ptep, pte);
>
> Probably not for this series but I wonder whether __xen_set_pte() should
> continue to use hypercall now that we are 64-bit only.

The hypercall path is a SYSCALL (and SYSRET out).

The "writeable" PTE path is a #PF, followed by an x86 instruction
emulation, which then reaches the same logic as the hypercall path (and
an IRET out).

~Andrew
