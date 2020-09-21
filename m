Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70EB6271F64
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 11:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgIUJ4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 05:56:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57981 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726333AbgIUJ4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 05:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600682171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DsUvRaONG6fEHsv/ssy29tFeXa+nzG7PzMsq9dyzlZE=;
        b=WAokWJkmK5CEbSYRgL4xqg7kfPbsc7KT3f1YTX4+UoIOAX/rbN6wI3gPu+aGBnHaK5JBhh
        jKhvFda/jSbKsBG6zQTOuAFNTIQDsJA5V6+PulnZHnkD1SpcfaU4fNlsZYLBFFjNN1v6VF
        SInXppgGnxmJYq+pKjK8pUrn6DRN/u8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-QCTLuNCDPzSB7EKN_sUGQg-1; Mon, 21 Sep 2020 05:56:08 -0400
X-MC-Unique: QCTLuNCDPzSB7EKN_sUGQg-1
Received: by mail-wr1-f69.google.com with SMTP id s8so5626341wrb.15
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 02:56:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DsUvRaONG6fEHsv/ssy29tFeXa+nzG7PzMsq9dyzlZE=;
        b=IzCjJSODkN2aUfZKxg9bSEqO5Urh9GCzvpS7rAGI8bUFUPDpmcvAU5KkegoRcpWDP6
         kbSv/4WXnBdB5rYk91mkmIFt/XYCMS/go2Rftbx8p0dU8P0CdxONr3FQKTFwYjuKA1sG
         OGVmuuqmDZJumjNFmPSQTbQa2t2Y2ABpRaOp6XZV5gL9ETmwgRnRom+0jh57BqffuCUf
         lufZ/bBrln2eOt2XX0oVPhpcGfqPyhh3kuOVH4DivLBJcIqHmYiPn+ucZaVIYVSMXOaR
         05p6tt6wibcxAe0lN/JoQ2vNobT2ceB//b3Domy5GpJxWN4RWQfedaZ/PJ3UUnKxqyWa
         QXvA==
X-Gm-Message-State: AOAM5313cEH0jP52ZOrykgIyTQZZgJmH/DVat0XAHQLcWhszobdeVIMG
        BaqnsDy9H6F+qbbDD3hh6n33LsJAjqYboVAu2meFDFDDj8sG5HyoQAVnWfR3e4dPyBdACRWazAN
        KfbWVnO1a4sCAX7UCN61v6IZW
X-Received: by 2002:a1c:7215:: with SMTP id n21mr30993482wmc.154.1600682166883;
        Mon, 21 Sep 2020 02:56:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGBox03QI6ysklI1sA9ptdIcpxBo+nq2uOBFaA6k3Et9K+sSEItN/jk0tTRLsfnai2hbJ4BQ==
X-Received: by 2002:a1c:7215:: with SMTP id n21mr30993462wmc.154.1600682166718;
        Mon, 21 Sep 2020 02:56:06 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:499:3d00:cd47:f651:9d80:157a? ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id m18sm18384578wmg.32.2020.09.21.02.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 02:56:06 -0700 (PDT)
Subject: Re: [PATCH 3/3] objtool: check: Handle calling non-function symbols
 in other sections
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mbenes@suse.cz
References: <20200915075318.7336-1-jthierry@redhat.com>
 <20200915075318.7336-4-jthierry@redhat.com>
 <20200918200740.3x6eookduesrgz3x@treble>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <5afa4c67-f557-b1c4-d94c-da7610f4fcbe@redhat.com>
Date:   Mon, 21 Sep 2020 10:56:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200918200740.3x6eookduesrgz3x@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/18/20 9:07 PM, Josh Poimboeuf wrote:
> On Tue, Sep 15, 2020 at 08:53:18AM +0100, Julien Thierry wrote:
>> Relocation for a call destination could point to a symbol that has
>> type STT_NOTYPE.
> 
> Then shouldn't the callee be changed to STT_FUNC?
> 

Not if it's a code symbol that does not follow standard calling convention.

It's really the same case as the !reloc, except this time it's in a 
different .text section. In arm64 there are different sections that are 
used (.text for basic code, .idmap.text for code mapped in a manner 
where virtual address == physical address, .hyp.text for kvm priviledged 
code, .tramp.text for trampolines...). There aren't many cases, but some 
symbols reference symbols in other sections, but the symbol being called 
isn't a proper function.



-- 
Julien Thierry

