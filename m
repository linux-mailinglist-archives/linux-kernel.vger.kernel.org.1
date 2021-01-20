Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE682FD97A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 20:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388052AbhATTXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 14:23:21 -0500
Received: from m42-8.mailgun.net ([69.72.42.8]:61785 "EHLO m42-8.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732407AbhATSsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:48:36 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611168490; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=3yGkJ8CECe99IYKCJvAG5sDtoQE2c9Ju5uVXlzxmMEQ=;
 b=plV5WydLOgfFAJAYugwW7cTswVvChrCcNP3iDWNwDUUxDlD+bekd+NX5PXj7YE3FAfU6oqDi
 PgI/K0119geZD10DA/x9pNPGDFirciDuApEImqzy24wX7aMKlTc+heZixfHKxvRiHoq1fuTL
 FR9CXNfdmOxYp1rXVN9RP98XHaU=
X-Mailgun-Sending-Ip: 69.72.42.8
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 60087acb2c36b2106d6d7cdd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 20 Jan 2021 18:47:39
 GMT
Sender: sudaraja=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F3077C43465; Wed, 20 Jan 2021 18:47:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sudaraja)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0E30FC433C6;
        Wed, 20 Jan 2021 18:47:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 20 Jan 2021 10:47:37 -0800
From:   Sudarshan Rajagopalan <sudaraja@codeaurora.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        anshuman.khandual@arm.com, david@redhat.com,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 1/1] arm64: reduce section size for sparsemem
In-Reply-To: <20210120174933.GA20981@willie-the-truck>
References: <cover.1610146597.git.sudaraja@codeaurora.org>
 <15cf9a2359197fee0168f820c5c904650d07939e.1610146597.git.sudaraja@codeaurora.org>
 <20210120174933.GA20981@willie-the-truck>
Message-ID: <9e23428b537611b3fd24eed75b9a81f0@codeaurora.org>
X-Sender: sudaraja@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-20 09:49, Will Deacon wrote:
> On Fri, Jan 08, 2021 at 03:16:00PM -0800, Sudarshan Rajagopalan wrote:
>> Reducing the section size helps reduce wastage of reserved memory
>> for huge memory holes in sparsemem model. But having a much smaller
>> section size bits could break PMD mappings for vmemmap and wouldn't
>> accomodate the highest order page for certain page size granule 
>> configs.
>> It is determined that SECTION_SIZE_BITS of 27 (128MB) could be ideal
>> default value for 4K_PAGES that gives least section size without 
>> breaking
>> PMD based vmemmap mappings. For simplicity, 16K_PAGES could follow the
>> same as 4K_PAGES. And the least SECTION_SIZE_BITS for 64K_PAGES is 29
>> that could accomodate MAX_ORDER.
>> 
>> Signed-off-by: Sudarshan Rajagopalan <sudaraja@codeaurora.org>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Cc: Mike Rapoport <rppt@linux.ibm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Suren Baghdasaryan <surenb@google.com>
>> ---
>>  arch/arm64/include/asm/sparsemem.h | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/arm64/include/asm/sparsemem.h 
>> b/arch/arm64/include/asm/sparsemem.h
>> index 1f43fcc79738..ff08ff6b677c 100644
>> --- a/arch/arm64/include/asm/sparsemem.h
>> +++ b/arch/arm64/include/asm/sparsemem.h
>> @@ -7,7 +7,13 @@
>> 
>>  #ifdef CONFIG_SPARSEMEM
>>  #define MAX_PHYSMEM_BITS	CONFIG_ARM64_PA_BITS
>> -#define SECTION_SIZE_BITS	30
>> -#endif
>> +
>> +#if defined(CONFIG_ARM64_4K_PAGES) || defined(CONFIG_ARM64_16K_PAGES)
>> +#define SECTION_SIZE_BITS 27
>> +#else
>> +#define SECTION_SIZE_BITS 29
>> +#endif /* CONFIG_ARM64_4K_PAGES || CONFIG_ARM64_16K_PAGES */
>> +
>> +#endif /* CONFIG_SPARSEMEM*/
> 
> Please can you repost this in light of the comments from Anshuman?
> 
> Thanks,
> 
> Will

Sure Will. We were held up with some other critical tasks.. will repost 
the patch by EOD after addressing Anshuman's comments.

-- 
Sudarshan

--
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
