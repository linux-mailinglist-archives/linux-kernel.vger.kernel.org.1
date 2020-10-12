Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8A828B222
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 12:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgJLKV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 06:21:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43110 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726658AbgJLKV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 06:21:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602498114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HDBTeWKsR+WSz7ogWTP5+7xq7Zt2sJLi3yvneC+dgKU=;
        b=ZDyn4qeA0D7Nm3Eh+gNlxdcFss0DC4CAreyxvGgOjUYieEnfEtrcivrsZTRIvrdcD8x5r0
        mELbauB4yPqUjHuUoX74EG7jCgP3PjWdIahmSksboe8mkYe9vi1eD3jxQtaEq0Ee0pripA
        8DZUdkEAtulfWW1WnxMAk5y2JtwImR8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-aNieVUP5P6KEHqZ_OhDyCw-1; Mon, 12 Oct 2020 06:21:52 -0400
X-MC-Unique: aNieVUP5P6KEHqZ_OhDyCw-1
Received: by mail-wm1-f69.google.com with SMTP id y83so5088213wmc.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 03:21:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HDBTeWKsR+WSz7ogWTP5+7xq7Zt2sJLi3yvneC+dgKU=;
        b=kAJsJcUOdu/aKUTGxXWzLNV08JYoayqdRqsaTzjTRMWIv3jM00yhhCQt4S906oMZF3
         DfXYTP6lNws6fKhLfb0yk6hM3ghDnJvSAvXnt0YEvo7+dEDniU9OrTXu12asAR2z4b02
         ZOPrNUliNUqEeimBN8UAXTovgGIfVgLg77u18RUK6VU3+YnvVPEYrrIIe99gfc+73z0W
         /4cE3Ehk1iyJgVO0qC9+VrJl47PbjLGzc0nfNsWE2VIAtN02jD8FtHhLXQtik0bbGLu0
         gQNc4pq822wIKNgWbbvHZhsX1x6xHAyOeApgyh7955SPqIWU72UjdcuB4V0fYthqgSB8
         M1TQ==
X-Gm-Message-State: AOAM531D8YF+4KW3CR2bGyU+w4QD4eaZdrEUPb2t1i9ssv8qkSvdpjZP
        i8bBcB+G1c36q1/wEq0Z/ORwBnODuELdtF3kZpW3wj06Q47LBF4cX4tjGWmj4TP3kc5dFlXNMaj
        639vmOOIf95tp6UcB1I6CugtJ
X-Received: by 2002:a7b:cf13:: with SMTP id l19mr10136825wmg.74.1602498111628;
        Mon, 12 Oct 2020 03:21:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbPNrVCw0L+LujyGpdebn7NEu9NDzfwj9obaxewRDDCTN5D74qfCH1bHBww39ekC+QJX24Ag==
X-Received: by 2002:a7b:cf13:: with SMTP id l19mr10136804wmg.74.1602498111412;
        Mon, 12 Oct 2020 03:21:51 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:499:3d00:cd47:f651:9d80:157a? ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id u15sm22035308wml.21.2020.10.12.03.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 03:21:50 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] objtool: check: Fully validate the stack frame
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org
References: <20200928093631.210610-1-jthierry@redhat.com>
 <20200928093631.210610-2-jthierry@redhat.com>
 <20200929191834.7daofidv6b5aef3y@treble>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <5540c2a9-db13-e05e-713c-22ec00f21aa6@redhat.com>
Date:   Mon, 12 Oct 2020 11:21:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200929191834.7daofidv6b5aef3y@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/29/20 8:18 PM, Josh Poimboeuf wrote:
> On Mon, Sep 28, 2020 at 10:36:29AM +0100, Julien Thierry wrote:
>> +++ b/tools/objtool/arch/x86/include/cfi_regs.h
>> @@ -22,4 +22,7 @@
>>   #define CFI_RA			16
>>   #define CFI_NUM_REGS		17
> 
> A few more naming nitpicks:
> 
>> +#define STACKFRAME_BP_OFFSET	-16
>> +#define STACKFRAME_RA_OFFSET	-8
> 
> "Stack frame" has more than one meaning now, I suppose.  i.e. it could
> also include the callee-saved registers and any other stack space
> allocated by the function.
> 
> Would "call frame" be clearer?
> 
>    CALL_FRAME_BP_OFFSET
>    CALL_FRAME_RA_OFFSET
> 
> ?

I would've thought that the call-frame could include the stackframe + 
other callee saved regs. Whereas stackframe tends to used for the 
caller's frame pointer + return address (i.e. what allows unwinding). 
Unless I'm getting lost with things.

And if call frame is associated with the region starting from the stack 
pointer at the parent call point (since this is what CFA is), then it 
shouldn't be associated with the framepointer + return address structure 
since this could be anywhere on the call frame (not at a fixed offset) 
as long as the new frame pointer points to the structure.

> 
>> +++ b/tools/objtool/cfi.h
>> @@ -35,4 +35,6 @@ struct cfi_state {
>>   	bool end;
>>   };
>>   
>> +#define STACKFRAME_SIZE	16
> 
> CALL_FRAME_SIZE ?
> 
> I'm sort of contradicting my previous comment here, but even though this
> value may be generic, it's also very much intertwined with the
> CALL_FRAME_{BP|RA}_OFFSET values.  So I get the feeling it really
> belongs in the arch-specific cfi_regs.h next to the other defines after
> all.
> 

Agreed.

-- 
Julien Thierry

