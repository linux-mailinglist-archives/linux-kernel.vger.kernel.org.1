Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3244A2CC01D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 15:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbgLBOwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 09:52:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21822 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728172AbgLBOwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 09:52:50 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B2EWswY186906;
        Wed, 2 Dec 2020 09:51:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=ecJDVzlbi1IKnaxUw/aAZpOseM53eXKxeDegftD9EL0=;
 b=VDg1QQHtFQ0FRPahW3KpdcEsWGpfaT8G3r9UcQeYNCi0NT+Ad5ZLEaU5haANqtat9FP4
 71rOCX5kwztNHUzvBdGfev9xeIINUdgjWPo0FaIGRP0QgLBaEeAQwpqvnPolQ4SRd/B6
 SCfiFT0xIBU9ckJuJxqQRnl7R0Rz/pc3qWikJQBeYSbG9423qJeCuR+LVdJmlA2HFMCu
 Q79o4jbxKKwfwdK6QBqvmeMWwJURxBhsUfnO1KXi2FVeC/DlB0DsHc4LUQB9yViIChcc
 ttewhzLF5SeJgwe9ZCR9KopQkCp5cNvhfsxUR/KBN6kbhb7PW8izuzFRmoAZD/Vb91Vf LA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 356a0v6ac5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 09:51:44 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B2EWuBj187230;
        Wed, 2 Dec 2020 09:51:43 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 356a0v6aa3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 09:51:43 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B2EmDME008317;
        Wed, 2 Dec 2020 14:51:40 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 354fpdb2s5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 14:51:40 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B2EpcrE59048310
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Dec 2020 14:51:38 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED64752051;
        Wed,  2 Dec 2020 14:51:37 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id AF6E65204E;
        Wed,  2 Dec 2020 14:51:35 +0000 (GMT)
Date:   Wed, 2 Dec 2020 20:21:35 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Jann Horn <jannh@google.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] x86/uprobes: Fix not using prefixes.nbytes for loop
 over prefixes.bytes
Message-ID: <20201202145135.GF528281@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <160689905099.3084105.7880450206184269465.stgit@devnote2>
 <160689907597.3084105.18019089399087866918.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <160689907597.3084105.18019089399087866918.stgit@devnote2>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-02_08:2020-11-30,2020-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 adultscore=0 clxscore=1011 suspectscore=1 lowpriorityscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012020089
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Masami Hiramatsu <mhiramat@kernel.org> [2020-12-02 17:51:16]:

> Since the insn.prefixes.nbytes can be bigger than the size of
> insn.prefixes.bytes[] when a same prefix is repeated, we have to
> check whether the insn.prefixes.bytes[i] != 0 and i < 4 instead
> of insn.prefixes.nbytes.
> 
> Fixes: 2b1444983508 ("uprobes, mm, x86: Add the ability to install and remove uprobes breakpoints")
> Cc: stable@vger.kernel.org
> Reported-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Looks good to me.

Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

> ---
>  arch/x86/kernel/uprobes.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 3fdaa042823d..bb3ea3705b99 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -257,7 +257,7 @@ static bool is_prefix_bad(struct insn *insn)
>  {
>  	int i;
> 
> -	for (i = 0; i < insn->prefixes.nbytes; i++) {
> +	for (i = 0; insn->prefixes.bytes[i] && i < 4; i++) {
>  		insn_attr_t attr;
> 
>  		attr = inat_get_opcode_attribute(insn->prefixes.bytes[i]);
> @@ -746,7 +746,7 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
>  	 * Intel and AMD behavior differ in 64-bit mode: Intel ignores 66 prefix.
>  	 * No one uses these insns, reject any branch insns with such prefix.
>  	 */
> -	for (i = 0; i < insn->prefixes.nbytes; i++) {
> +	for (i = 0; insn->prefixes.bytes[i] && i < 4; i++) {
>  		if (insn->prefixes.bytes[i] == 0x66)
>  			return -ENOTSUPP;
>  	}
> 

-- 
Thanks and Regards
Srikar Dronamraju
