Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373952C2825
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 14:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388402AbgKXNfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 08:35:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10084 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725616AbgKXNfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:35:54 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AODWDer139473;
        Tue, 24 Nov 2020 08:33:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Up34+xk5Hh3uaem2s98GkoXOQa+MmxHIken7R58zN+4=;
 b=dMh9axdbsIw2m80Vbx02bRag9DhvhSNV0b/2Vt5aOC8PbC4zWV2v3cp/MGZGmd+aEXXi
 EYbRtM/MQKwgjNrPnbwRebJCFsyEPWVoDImHSSoGuCFhMcbA5rHwPzwFT5JrOmzp8O2m
 MLZ+Oe0wa8DKyvy5D+k/6wJJPlt17HOsCd8XbW32ubbL4+rKILe1CLcL88/Qsx5NT5E5
 mgeINfSUNR4Iu218OicpmS0POxFOObZMQdO/Q/SGOlWVJQBjMf7B2M8p8h8JkwDaHDFW
 6yiX1nbertg3y28BGfVWyJ9RVqhw1Pfq5jwTgJl20RGDwA1EUwdI8wRwFlkco7MsAE4f 1A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 350rn9c9fx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Nov 2020 08:33:17 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AODXHJT145235;
        Tue, 24 Nov 2020 08:33:17 -0500
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 350rn9c9ek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Nov 2020 08:33:17 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AODSgO1026468;
        Tue, 24 Nov 2020 13:33:15 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 34y6k4smn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Nov 2020 13:33:14 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AODXC5b4784770
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Nov 2020 13:33:12 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97B2711C050;
        Tue, 24 Nov 2020 13:33:12 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E427D11C04A;
        Tue, 24 Nov 2020 13:33:11 +0000 (GMT)
Received: from localhost (unknown [9.171.12.143])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 24 Nov 2020 13:33:11 +0000 (GMT)
Date:   Tue, 24 Nov 2020 14:33:10 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Julien Thierry <jthierry@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/insn: Fix vector instructions decoding on big endian
Message-ID: <your-ad-here.call-01606224790-ext-4442@work.hours>
References: <cover.thread-1e2854.your-ad-here.call-01605220128-ext-6070@work.hours>
 <patch.git-a153abbe9170.your-ad-here.call-01605283379-ext-7358@work.hours>
 <20201113173052.vdy72pytmv6ztnbj@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201113173052.vdy72pytmv6ztnbj@treble>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-24_04:2020-11-24,2020-11-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=932 mlxscore=0 adultscore=0 suspectscore=1
 impostorscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011240081
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 11:30:52AM -0600, Josh Poimboeuf wrote:
> On Fri, Nov 13, 2020 at 05:09:54PM +0100, Vasily Gorbik wrote:
> > Running instruction decoder posttest on s390 with allyesconfig shows
> > errors. Instructions used in couple of kernel objects could not be
> > correctly decoded on big endian system.
> > 
> > insn_decoder_test: warning: objdump says 6 bytes, but insn_get_length() says 5
> > insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
> > insn_decoder_test: warning: ffffffff831eb4e1:    62 d1 fd 48 7f 04 24    vmovdqa64 %zmm0,(%r12)
> > insn_decoder_test: warning: objdump says 7 bytes, but insn_get_length() says 6
> > insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
> > insn_decoder_test: warning: ffffffff831eb4e8:    62 51 fd 48 7f 44 24 01         vmovdqa64 %zmm8,0x40(%r12)
> > insn_decoder_test: warning: objdump says 8 bytes, but insn_get_length() says 6
> > 
> > This is because in few places instruction field bytes are set directly
> > with further usage of "value". To address that introduce and use
> > insn_set_byte() helper, which correctly updates "value" on big endian
> > systems.
> > 
> > Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> > ---
> >  Please let me know if this patch is good as it is or I should squash it
> >  into the patch 2 of my patch series and resend it again.
> 
> It all looks good to me, thanks!
> 
> Masami, does this patch look good, and also patches 1-2 of the series?
> (I think you previously ACKed patch 2).
> 

Friendly ping...
