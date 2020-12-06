Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205132D02B9
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 11:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgLFK0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 05:26:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43793 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725867AbgLFK0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 05:26:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607250323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Cs8fezBVb11/ZrMhV5N07RL46IYvKZ6+nnIIc/dB4c=;
        b=TBLRHAWQFXZ4PmtyQ/petrFdM07+UB9B4CQDaqH1FtjXwR1jvJDixGjb1q6/SVAdOmCRNx
        oR2KAKvCnMYHGvBf38g5qGA1oNvcjPay558CyKdO8XZTqLiIRucRcLipmT/VhokbDBnsIk
        sqm3vVpDDPZ0+jiFNF7zgphvke5zMSk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-QdUEtiHfPU2H8OpgjVn8Iw-1; Sun, 06 Dec 2020 05:25:21 -0500
X-MC-Unique: QdUEtiHfPU2H8OpgjVn8Iw-1
Received: by mail-wr1-f72.google.com with SMTP id v1so4129092wri.16
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 02:25:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3Cs8fezBVb11/ZrMhV5N07RL46IYvKZ6+nnIIc/dB4c=;
        b=kX/jR5Lt2aBllDUnrhE2DQS3cY+Wm7nHLHbrNkiUrZLtXz0iKdGZVcxUo2fLVvEPXZ
         7zX1vuU8YY2IaTHJR3NLgW1KP4MuXl5+nryEAlzVvXCTdPVMnv2TCMvBraMiFl/OFY4H
         77E6XMo08OcLBjB7zpLSv26GF9RJ/OkE3V7ZdnYhJpF5+Drw2ozWub7fjJrjBiFc54Du
         IQCxvIGXzNdHWvpwZMUNfTsd17fcrmrwvfYLQAhGt5S8LmKBEcxSM3RXLzZK0PMEgRiR
         2KqDLKURFa/sQ5HtjATp1QNk7BBKvulNvNCcqWhAi6Dhb+D4fKo1M3/dSRE2G1qH3ELc
         qjFQ==
X-Gm-Message-State: AOAM531Jj2vOa/Vj05CMHbeWIQ1k7RhdP8O1VgHjEYWyqggtpH2W7A67
        LdFh2sD+FxrXstXoZJN/u8+Pvc9adjXa2jlzff/QNS0XeOwk3PPmSNImWBjQ0lk8phW3PqqdIWA
        XoULAnEzlhQAFUZJG94obFK2v
X-Received: by 2002:a1c:e10b:: with SMTP id y11mr13443651wmg.65.1607250320792;
        Sun, 06 Dec 2020 02:25:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxk0uA8SEzu1YeOhx3w2fdQXUjS5HSHMQ24JKOD85Sg4hidvHJs9RCcT67xw0Wy3NcOdh8jfA==
X-Received: by 2002:a1c:e10b:: with SMTP id y11mr13443623wmg.65.1607250320609;
        Sun, 06 Dec 2020 02:25:20 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id q17sm10489024wrr.53.2020.12.06.02.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Dec 2020 02:25:19 -0800 (PST)
Subject: Re: [PATCH v2 2/9] KVM: X86: Introduce KVM_HC_PAGE_ENC_STATUS
 hypercall
To:     Ashish Kalra <ashish.kalra@amd.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        joro@8bytes.org, bp@suse.de, thomas.lendacky@amd.com,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        srutherford@google.com, brijesh.singh@amd.com,
        dovmurik@linux.vnet.ibm.com, tobin@ibm.com, jejb@linux.ibm.com,
        frankeh@us.ibm.com
References: <cover.1606782580.git.ashish.kalra@amd.com>
 <40acca4b49cd904ea73038309908151508fb555c.1606782580.git.ashish.kalra@amd.com>
 <20201202165420.GI3226@work-vm>
 <20201202212232.GB14672@ashkalra_ubuntu_server>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5813902a-f272-a6fe-b32c-c470cb18c1ff@redhat.com>
Date:   Sun, 6 Dec 2020 11:25:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201202212232.GB14672@ashkalra_ubuntu_server>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/20 22:22, Ashish Kalra wrote:
> Hello Dave,
> 
> On Wed, Dec 02, 2020 at 04:54:20PM +0000, Dr. David Alan Gilbert wrote:
>> * Ashish Kalra (Ashish.Kalra@amd.com) wrote:
>>> From: Brijesh Singh <brijesh.singh@amd.com>
>>>
>>> This hypercall is used by the SEV guest to notify a change in the page
>>> encryption status to the hypervisor. The hypercall should be invoked
>>> only when the encryption attribute is changed from encrypted -> decrypted
>>> and vice versa. By default all guest pages are considered encrypted.
>>
>> Is it defined whether these are supposed to be called before or after
>> the the page type has been changed; is it change the type and then
>> notify or the other way around?

It doesn't matter.  However, you have do it before writing to the page, 
and the content of the page is unspecified between the hypercall and the 
write to the page.

So you cannot for example encrypt a page in place (using the same PFN 
but different settings of the C bit), you need to do:

	hypercall(); /* mark enc_data as encrypted */
	/*
	 * The contents of enc_data is now undefined as it can change
	 * across migration.
	 */
	memset(enc_data, unenc_data, PAGE_SIZE);

Paolo

