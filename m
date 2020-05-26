Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE7D1A1718
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 23:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgDGVBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 17:01:31 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41542 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgDGVBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 17:01:31 -0400
Received: by mail-pf1-f193.google.com with SMTP id a24so1360129pfc.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 14:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=xOIs/aYyoEYRxoIMxQO5osoz1PpwH/skvHRPL3334M4=;
        b=CHeRs6j021xT8bWjLDrrWBLWK9V8VLw7f2UsAFSw4lxOjoEHyaaYyP0dEPfbOIBjEK
         i+3negRDUjEyBG/x3o4tokMia9jkInKAhBMrUg76qlHucqxULZtrH9GbO/YDs6Z4Iuzw
         YljopLtG59nXQWQNMYvAnK4Ma6cee3yKmOysIU7vjNWVKlFJs7BYlDmb8ZD1m0GE7bO0
         5T9BLY3mHFo4YPmGm8Yfl41kNcHw/73lrl3ElU3HwsZp0/yN2AZRVS/1potj2lFmOp8u
         9/B1YW8ZqIRo3REH+7pZHa5oi4+umorNiZTyWfngg+I8izGlK1GxPIVSrJoiiKkDy91Y
         jNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=xOIs/aYyoEYRxoIMxQO5osoz1PpwH/skvHRPL3334M4=;
        b=GvXo/TvhlUpw0hJy58VFng6yCACz7vD79nLwpaLB5sPAXzxTkoO9YYgTXxCu92ZrsC
         lOruE+/qUOQ2TsTiCNdjC19PByyxBNjKV2BVT9LxGxp9tRzJyECPatcGzQz+tXWfqVVR
         q51uS+GhJW8V0oEDW4H39vIoyMr9QZY993dZSCOwDBatj7A71aJuWo7p8j8GQBu60V9U
         7BJUtRQwhsZa5Y/f75O9ATGYtghNDiodx3StmfMcw0tXoPw9cCrSLFEcelpPLIMIjIbj
         /6Q2aaqYwrzFr0FJiYEZ3FGfXzNz6gAPwJvBzOvGsrTQlqEkeuXq7PsDn87VH7fLyR/U
         a+0g==
X-Gm-Message-State: AGi0PuYv6FCWJYITyMlPuJ5jU71Mh6bQGBExmissR7wDKv1hcw88fekr
        ka5VemH2Mv5wb3ZYkq+wDX/xRsZ2jBk=
X-Google-Smtp-Source: APiQypJVl+kUONdeDY7nQlJiv7QwGFUK9xO5VnrEKlgUhPzyv4hciH9FG0pjCOC1NTF8uV8IAPdVKA==
X-Received: by 2002:a63:6e06:: with SMTP id j6mr3882546pgc.167.1586293290368;
        Tue, 07 Apr 2020 14:01:30 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:34fd:1e6:3333:93da? ([2601:646:c200:1ef2:34fd:1e6:3333:93da])
        by smtp.gmail.com with ESMTPSA id e26sm3037092pff.167.2020.04.07.14.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 14:01:29 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: hv_hypercall_pg page permissios
Date:   Tue, 7 Apr 2020 14:01:25 -0700
Message-Id: <C311EB52-A796-4B94-AADD-CCABD19B377E@amacapital.net>
References: <20200407073830.GA29279@lst.de>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
In-Reply-To: <20200407073830.GA29279@lst.de>
To:     Christoph Hellwig <hch@lst.de>
X-Mailer: iPhone Mail (17E255)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Apr 7, 2020, at 12:38 AM, Christoph Hellwig <hch@lst.de> wrote:
>=20
> =EF=BB=BFOn Tue, Apr 07, 2020 at 09:28:01AM +0200, Vitaly Kuznetsov wrote:=

>> Christoph Hellwig <hch@lst.de> writes:
>>=20
>>> Hi all,
>>>=20
>>> The x86 Hyper-V hypercall page (hv_hypercall_pg) is the only allocation
>>> in the kernel using __vmalloc with exectutable persmissions, and the
>>> only user of PAGE_KERNEL_RX.  Is there any good reason it needs to
>>> be readable?  Otherwise we could use vmalloc_exec and kill off
>>> PAGE_KERNEL_RX.  Note that before 372b1e91343e6 ("drivers: hv: Turn off
>>> write permission on the hypercall page") it was even mapped writable..
>>=20
>> [There is nothing secret in the hypercall page, by reading it you can
>> figure out if you're running on Intel or AMD (VMCALL/VMMCALL) but it's
>> likely not the only possible way :-)]
>>=20
>> I see no reason for hv_hypercall_pg to remain readable. I just
>> smoke-tested
>=20
> Thanks, I have the same in my WIP tree, but just wanted to confirm this
> makes sense.

Just to make sure we=E2=80=99re all on the same page: x86 doesn=E2=80=99t no=
rmally have an execute-only mode. Executable memory in the kernel is readabl=
e unless you are using fancy hypervisor-based XO support.=
