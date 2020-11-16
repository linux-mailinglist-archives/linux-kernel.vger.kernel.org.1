Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70502B3FCC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 10:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgKPJdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 04:33:50 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:30642 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbgKPJdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 04:33:49 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605519229; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=P698r6QVcWi7gJVt5PbJbTnDn3TXyQARl7Szjb9POHI=;
 b=J+cILDkRZ+EbFqoAS89Feq+okOwADgZ/1sXJcBjW/XxhEKj076DAS3pCeQkJ8QkDSbsWRtpv
 QPGNUXygPM4praODD3NeN+Wozyslgr0dWxJdazTF9UxV3K9LtSden64XaiChbNNAkSb0iUa6
 UJkuU3YtHW2nXwC4psvyLUfGgjk=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5fb2476f40d44461259422fe (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 16 Nov 2020 09:33:35
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6B59EC433ED; Mon, 16 Nov 2020 09:33:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 98D12C433C6;
        Mon, 16 Nov 2020 09:33:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 16 Nov 2020 17:33:34 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     kernel test robot <rong.a.chen@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: drivers/net/wireless/ath/ath10k/sdio.c:2234:2: warning:
 Non-boolean value returned from function returning bool
In-Reply-To: <87o8jx20w6.fsf@codeaurora.org>
References: <20201116055212.GA3723@shao2-debian>
 <87o8jx20w6.fsf@codeaurora.org>
Message-ID: <32eb018069a079fd82e359d0ed4e1b1e@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-16 15:53, Kalle Valo wrote:
> + ath10k list
> 
> kernel test robot <rong.a.chen@intel.com> writes:
> 
>> tree:   
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
>> master
>> head:   f01c30de86f1047e9bae1b1b1417b0ce8dcd15b1
>> commit: 3c45f21af84eb05a355919abc80cf70a3a681cee ath10k: sdio: add
>> firmware coredump support
>> compiler: nios2-linux-gcc (GCC) 9.3.0
>> 
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <rong.a.chen@intel.com>
>> 
>> 
>> cppcheck possible warnings: (new ones prefixed by >>, may not real 
>> problems)
>> 
>>>> drivers/net/wireless/ath/ath10k/sdio.c:2234:2: warning: Non-boolean
>> value returned from function returning bool
>> [returnNonBoolInBooleanFunction]
>>     return param & HI_OPTION_SDIO_CRASH_DUMP_ENHANCEMENT_FW;
>>     ^
> 
> Is this really a problem? I guess we could change that to "!!(param &
> HI_OPTION_SDIO_CRASH_DUMP_ENHANCEMENT_FW)" but how is that better and
> does it make any practical difference when
> ath10k_sdio_is_fast_dump_supported() returns a boolean anyway?
It should not be a real problem by test before.
ath10k_sdio_is_fast_dump_supported return true in test before.
and fast_dump get true from ath10k_sdio_is_fast_dump_supported in 
ath10k_sdio_fw_crashed_dump.

the risk maybe like this:
u32 param in ath10k_sdio_is_fast_dump_supported is 4 bytes, and bool is 
1 byte.
if Gcc does not do any convertion from u32 to bool, then the bool value 
will only
get the lower byte(byte 0) of the 4 bytes, then maybe get an mistake 
result.

I did a disassemble of sdio.o with/without below change, and dump 
sdio.o, it have no difference in this place:
I change send a patch with below change if needed.
@@ -2231,7 +2231,7 @@ static bool 
ath10k_sdio_is_fast_dump_supported(struct ath10k *ar)

         ath10k_dbg(ar, ATH10K_DBG_SDIO, "sdio hi_option_flag2 %x\n", 
param);

-       return param & HI_OPTION_SDIO_CRASH_DUMP_ENHANCEMENT_FW;
+       return !!(param & HI_OPTION_SDIO_CRASH_DUMP_ENHANCEMENT_FW);
  }

objdump -Sl sdio.o > sdio.o-Sl.txt

0000000000002b00 <ath10k_sdio_fw_crashed_dump>:
void ath10k_sdio_fw_crashed_dump(struct ath10k *ar)
{
...
/home/wgong/ath11k/ath-master/ath/drivers/net/wireless/ath/ath10k/sdio.c:2234

	return param & HI_OPTION_SDIO_CRASH_DUMP_ENHANCEMENT_FW;
     2b75:	8b 44 24 44          	mov    0x44(%rsp),%eax
     2b79:	25 00 08 00 00       	and    $0x800,%eax //"the SF, ZF, and PF 
flags are set according to the result".ZF will be 0 if true.
     2b7e:	89 44 24 2c          	mov    %eax,0x2c(%rsp)
     2b82:	40 0f 95 c5          	setne  %bpl //"Set byte if not equal 
(ZF=0)".stored the ZF flag to bpl as value of fast_dump.
ath10k_sdio_fw_crashed_dump():
/home/wgong/ath11k/ath-master/ath/drivers/net/wireless/ath/ath10k/sdio.c:2483
	char guid[UUID_STRING_LEN + 1];
	bool fast_dump;

	fast_dump = ath10k_sdio_is_fast_dump_supported(ar);

	if (fast_dump)
     2b86:	0f 85 c3 03 00 00    	jne    2f4f 
<ath10k_sdio_fw_crashed_dump+0x44f> //"Jump near if not equal (ZF=0)"
...
/home/wgong/ath11k/ath-master/ath/drivers/net/wireless/ath/ath10k/sdio.c:2499
	ath10k_sdio_dump_registers(ar, crash_data, fast_dump);
     2be5:	40 0f b6 d5          	movzbl %bpl,%edx //use the bpl stored as 
value of fast_dump
     2be9:	48 89 de             	mov    %rbx,%rsi
     2bec:	4c 89 ff             	mov    %r15,%rdi
     2bef:	e8 8c fb ff ff       	callq  2780 <ath10k_sdio_dump_registers>

