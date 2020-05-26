Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B741AE3D7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 19:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbgDQRd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 13:33:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43380 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728602AbgDQRd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 13:33:26 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03HHSPNV012691;
        Fri, 17 Apr 2020 17:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=RzseDlMhwGgi4YriRptBfsw8qio9XEDdkLQdob+UF6Y=;
 b=Ezui3zdc/SK7BAe+cZxHNvueXdGwu4NK9CPv2raE1/tMBMJ5+fUrMbV/TTpP06h303Hz
 3unllPq7/KegUjnzOgdx5clWZWUQGjResyRJLKwyWapTrag0Wghos2sD3LH6RoXMXaVf
 1CkJLRI5RF+dWEDJ+7zqDQcgDmt16z87W/hzFQuTB/sFIep57RumKlaV+onpzeK2qDaz
 ALQ3pvbllhC1LkHfJEGBJJhm9caEpfXdzJnnsLY3n9Yqt+PFbcIumV5L6OL76nqgZeWz
 spU1S90xzfTncLLXp2PZ0UpnyMbGlolNqXSp6+IRU13jyLtXnPvmhCCqAYDDpe4UVDw+ tw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 30dn960ce1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Apr 2020 17:33:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03HHVwDA121075;
        Fri, 17 Apr 2020 17:33:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 30dyp3465h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Apr 2020 17:33:00 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03HHWwR5011500;
        Fri, 17 Apr 2020 17:32:58 GMT
Received: from linux-1.home (/10.175.17.90)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 17 Apr 2020 10:32:58 -0700
Subject: Re: [PATCH v5 02/17] objtool: Better handle IRET
To:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz, jthierry@redhat.com
References: <20200416114706.625340212@infradead.org>
 <20200416115118.631224674@infradead.org>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <8692ee18-e553-6f90-5291-62d6d57407cd@oracle.com>
Date:   Fri, 17 Apr 2020 19:37:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200416115118.631224674@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9594 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=2
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004170136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9594 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 phishscore=0 spamscore=0 impostorscore=0 suspectscore=2
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004170135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/16/20 1:47 PM, Peter Zijlstra wrote:
> Teach objtool a little more about IRET so that we can avoid using the
> SAVE/RESTORE annotation. In particular, make the weird corner case in
> insn->restore go away.
> 
> The purpose of that corner case is to deal with the fact that
> UNWIND_HINT_RESTORE lands on the instruction after IRET, but that
> instruction can end up being outside the basic block, consider:
> 
> 	if (cond)
> 		sync_core()
> 	foo();
> 
> Then the hint will land on foo(), and we'll encounter the restore
> hint without ever having seen the save hint.
> 
> By teaching objtool about the arch specific exception frame size, and
> assuming that any IRET in an STT_FUNC symbol is an exception frame
> sized POP, we can remove the use of save/restore hints for this code.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   arch/x86/include/asm/processor.h |    2 --
>   tools/objtool/arch.h             |    1 +
>   tools/objtool/arch/x86/decode.c  |   14 ++++++++++++--
>   tools/objtool/check.c            |   29 ++++++++++++++++-------------
>   4 files changed, 29 insertions(+), 17 deletions(-)
> 
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -727,7 +727,6 @@ static inline void sync_core(void)
>   	unsigned int tmp;
>   
>   	asm volatile (
> -		UNWIND_HINT_SAVE
>   		"mov %%ss, %0\n\t"
>   		"pushq %q0\n\t"
>   		"pushq %%rsp\n\t"
> @@ -737,7 +736,6 @@ static inline void sync_core(void)
>   		"pushq %q0\n\t"
>   		"pushq $1f\n\t"
>   		"iretq\n\t"
> -		UNWIND_HINT_RESTORE
>   		"1:"
>   		: "=&r" (tmp), ASM_CALL_CONSTRAINT : : "cc", "memory");
>   #endif
> --- a/tools/objtool/arch.h
> +++ b/tools/objtool/arch.h
> @@ -19,6 +19,7 @@ enum insn_type {
>   	INSN_CALL,
>   	INSN_CALL_DYNAMIC,
>   	INSN_RETURN,
> +	INSN_EXCEPTION_RETURN,
>   	INSN_CONTEXT_SWITCH,
>   	INSN_STACK,
>   	INSN_BUG,
> --- a/tools/objtool/arch/x86/decode.c
> +++ b/tools/objtool/arch/x86/decode.c
> @@ -435,9 +435,19 @@ int arch_decode_instruction(struct elf *
>   		*type = INSN_RETURN;
>   		break;
>   
> +	case 0xcf: /* iret */
> +		*type = INSN_EXCEPTION_RETURN;
> +
> +		/* add $40, %rsp */
> +		op->src.type = OP_SRC_ADD;
> +		op->src.reg = CFI_SP;
> +		op->src.offset = 5*8;
> +		op->dest.type = OP_DEST_REG;
> +		op->dest.reg = CFI_SP;
> +		break;
> +
>   	case 0xca: /* retf */
>   	case 0xcb: /* retf */
> -	case 0xcf: /* iret */
>   		*type = INSN_CONTEXT_SWITCH;
>   		break;
>   
> @@ -483,7 +493,7 @@ int arch_decode_instruction(struct elf *
>   
>   	*immediate = insn.immediate.nbytes ? insn.immediate.value : 0;
>   
> -	if (*type == INSN_STACK)
> +	if (*type == INSN_STACK || *type == INSN_EXCEPTION_RETURN)
>   		list_add_tail(&op->list, ops_list);
>   	else
>   		free(op);
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -2080,15 +2080,14 @@ static int validate_return(struct symbol
>    * tools/objtool/Documentation/stack-validation.txt.
>    */
>   static int validate_branch(struct objtool_file *file, struct symbol *func,
> -			   struct instruction *first, struct insn_state state)
> +			   struct instruction *insn, struct insn_state state)
>   {
>   	struct alternative *alt;
> -	struct instruction *insn, *next_insn;
> +	struct instruction *next_insn;
>   	struct section *sec;
>   	u8 visited;
>   	int ret;
>   
> -	insn = first;
>   	sec = insn->sec;
>   
>   	if (insn->alt_group && list_empty(&insn->alts)) {
> @@ -2141,16 +2140,6 @@ static int validate_branch(struct objtoo
>   				}
>   
>   				if (!save_insn->visited) {
> -					/*
> -					 * Oops, no state to copy yet.
> -					 * Hopefully we can reach this
> -					 * instruction from another branch
> -					 * after the save insn has been
> -					 * visited.
> -					 */
> -					if (insn == first)
> -						return 0;
> -
>   					WARN_FUNC("objtool isn't smart enough to handle this CFI save/restore combo",
>   						  sec, insn->offset);
>   					return 1;
> @@ -2243,6 +2232,20 @@ static int validate_branch(struct objtoo
>   
>   			break;
>   
> +		case INSN_EXCEPTION_RETURN:
> +			if (handle_insn_ops(insn, &state))
> +				return 1;

Do we need to update the stack state for normal IRET? This wasn't done before.
So shouldn't this better be:

                case INSN_EXCEPTION_RETURN:
                         if (!func)
                                 return 0;

                         if (handle_insn_ops(insn, &state))
                                 return 1;

                         break;

> +
> +			/*
> +			 * This handles x86's sync_core() case, where we use an
> +			 * IRET to self. All 'normal' IRET instructions are in
> +			 * STT_NOTYPE entry symbols.
> +			 */
> +			if (func)
> +				break;

Is it worth checking that func->name is effectively "sync_core"?

alex.

> +
> +			return 0;
> +
>   		case INSN_CONTEXT_SWITCH:
>   			if (func && (!next_insn || !next_insn->hint)) {
>   				WARN_FUNC("unsupported instruction in callable function",
> 
> 
