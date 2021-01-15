Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0B42F87FF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 22:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbhAOV4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 16:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbhAOV4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 16:56:04 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AABC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 13:55:24 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id i7so6866363pgc.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 13:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc:message-id:references
         :to;
        bh=iuYOuxzRIZhnGs5rPmpjf/3pmv0yomzoKCb5UzD5W7I=;
        b=h0bDkPR9jVLPitwlUQJHelmcPU/OpX010FQM94uZVvQSp8iUdtSW+XBHtvu5lQ4Jc0
         MD/ka1UUtQxVXaAWgTqq0Ehf6r1WiMVwiYo60oRMpIA7Cc4Uynbe/E2FW6PTzwm0D1pO
         9FUL03zc8sCU2RId7q7oV+77K6deMLM+Qu7TA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :message-id:references:to;
        bh=iuYOuxzRIZhnGs5rPmpjf/3pmv0yomzoKCb5UzD5W7I=;
        b=sGV5dkEDq7cZdJXrOXvxQ1ynoQpnnzhfOkAlRmmqY12hkHv2WDIaEjt0e38/hPPzkp
         I2FRYsBoxOO82CXoA6gmx4cgJrDdSRJEXn557U9o6fTGM1iNTBHJXmbpjdoUWOHEWoUu
         VLy8FiTnVkC0spvcNULgB1wFhSs28nqXt0TY+6nUtS0AflQCQbgxFJZEhXgHSmRo10Qt
         zRBmP4/ASLjrWerOCAHKpT0UsnogGj6syj/5BFLICOZycGWrF/J9JU5S2AZ2k4vUCQQA
         SKjBotyTx8Sm07qXcSMxCO60B6f6wqORYBBEUnT/ALgOEO4ZG1vrrbW3E0cRZA2OVhXU
         RVkA==
X-Gm-Message-State: AOAM533itHXyq0LgqLqvkJsnEQav8O3fuZ2I67c2WmzdUhvPztpDgl1P
        E9dkSjxp1fIRPgQjvFrzfhMMvSen3vNMdRgyLfHttR2aNeRmRxTsrurvI1Gxjpm8GNGNQf0GnAO
        z6C0Ovl5sMftx77r6CTv2gAc=
X-Google-Smtp-Source: ABdhPJwyB60E1ZyJEl94z/J3lCuLtfI2GphQyHKlWMrltGUowuym1gyhs3DVZhIU9beabzYI/nr/xw==
X-Received: by 2002:a63:1863:: with SMTP id 35mr14978339pgy.191.1610747723694;
        Fri, 15 Jan 2021 13:55:23 -0800 (PST)
Received: from c02z85t5lvdr.dhcp.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id b18sm9214833pfi.173.2021.01.15.13.55.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jan 2021 13:55:23 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] mailbox: bcm: Replace tasklet with threaded irq
From:   Rob Rice <rob.rice@broadcom.com>
In-Reply-To: <20210115035327.xckiigalv3qps7ke@offworld>
Date:   Fri, 15 Jan 2021 16:55:21 -0500
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>
Message-Id: <900BDAE9-8FF1-41C8-B909-D897BCAF3445@broadcom.com>
References: <20210115002134.117637-1-dave@stgolabs.net>
 <CABb+yY381GYcfAkLuzSTvNz2yHGs4Ap7Kgwiy9r0pXGGQt+ozg@mail.gmail.com>
 <20210115035327.xckiigalv3qps7ke@offworld>
To:     Davidlohr Bueso <dave@stgolabs.net>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000eaa17b05b8f76d4e"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000eaa17b05b8f76d4e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Davidlohr,

I haven=E2=80=99t worked on this driver for 4 years. So my memory is a litt=
le vague. But I have notes that we found using the tasklet was 40% faster t=
han threaded IRQ. We were trying to get performance up. So that seemed impo=
rtant at the time. I=E2=80=99m not prepared to defend that now. :-)

Rob

> On Jan 14, 2021, at 10:53 PM, Davidlohr Bueso <dave@stgolabs.net> wrote:
>=20
> On Thu, 14 Jan 2021, Jassi Brar wrote:
>=20
>> On Thu, Jan 14, 2021 at 6:21 PM Davidlohr Bueso <dave@stgolabs.net> wrot=
e:
>>>=20
>>> Tasklets have long been deprecated as being too heavy on the system
>>> by running in irq context - and this is not a performance critical
>>> path. If a higher priority process wants to run, it must wait for
>>> the tasklet to finish before doing so.
>>>=20
>>> Use a more suitable alternative such as threaded irqs and do the
>>> async work in process context.
>>>=20
>>> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
>>> ---
>> Please cc the author and other contributors to this file, esp when
>> this is vendor specific code.
>=20
> So looking at who to Cc I noticed:
>=20
> commit 8aef00f090bcbe5237c5a6628e7c000890267efe
> Author: Rob Rice <rob.rice@broadcom.com>
> Date:   Mon Nov 14 13:26:01 2016 -0500
>=20
>    mailbox: bcm-pdc: Convert from threaded IRQ to tasklet
>=20
>    Previously used threaded IRQs in the PDC driver to defer
>    processing the rx DMA ring after getting an rx done interrupt.
>    Instead, use a tasklet at normal priority for deferred processing.
>=20
> ... which is exactly the opposite of what modern Linux should be
> doing. Rob, could this not be done in process context?
>=20
> Thanks,
> Davidlohr


--=20
This electronic communication and the information and any files transmitted=
=20
with it, or attached to it, are confidential and are intended solely for=20
the use of the individual or entity to whom it is addressed and may contain=
=20
information that is confidential, legally privileged, protected by privacy=
=20
laws, or otherwise restricted from disclosure to anyone else. If you are=20
not the intended recipient or the person responsible for delivering the=20
e-mail to the intended recipient, you are hereby notified that any use,=20
copying, distributing, dissemination, forwarding, printing, or copying of=
=20
this e-mail is strictly prohibited. If you received this e-mail in error,=
=20
please return the e-mail to the sender, delete it from your computer, and=
=20
destroy any printed copy of it.

--000000000000eaa17b05b8f76d4e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
lUReXD6ch7MiIr8fnwB1L8YDGzV/z06h7ddxgv/5C707N5UQAjL3cZ1CWhhK/QIDAQABo4IBzDCC
AcgwDgYDVR0PAQH/BAQDAgWgMIGeBggrBgEFBQcBAQSBkTCBjjBNBggrBgEFBQcwAoZBaHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NwZXJzb25hbHNpZ24yc2hhMmczb2NzcC5j
cnQwPQYIKwYBBQUHMAGGMWh0dHA6Ly9vY3NwMi5nbG9iYWxzaWduLmNvbS9nc3BlcnNvbmFsc2ln
bjJzaGEyZzMwTQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8v
d3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwRAYDVR0fBD0wOzA5oDeg
NYYzaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc3BlcnNvbmFsc2lnbjJzaGEyZzMuY3JsMCAG
A1UdEQQZMBeBFXJvYi5yaWNlQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBRpcoJiMWeVRIV3kYDEBDZJnXsLYTAdBgNVHQ4EFgQUeeWPL7OYddruQwa9eoQqPZqp
9SwwDQYJKoZIhvcNAQELBQADggEBAB01BGF8+niBxyE2AFtFvz779RwbCf2EwxfxWF5dhKr4m5o9
bd7yGjSb1IIYGk+k7rJp6Mjc6W4yG1HdHk7hAe05QKM7P+AVNQISeDArwCposXjY+kM+Kcu1ohJ7
4gmrEWMf38bOjSoW/jMtJNT3g5a9J1PlyWXNf8vS2GCq4FDNhmaaj5yUQBE+9DuFEE5NaVFMDR93
TX7px/fvQ8glYrckirqQej+CsP1vPuJc5VUwxDeSF8G1wZAk+KX+QlU3YMlt8ecUn+uZu/kWp/2I
byfxL9iDdQT7v+j5FoRcECCKjir57K4WggCS3cetD/DWylqSEHKXyB0dOpAXkctgTMAxggJvMIIC
awIBATBtMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTMwMQYDVQQD
EypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENBIC0gU0hBMjU2IC0gRzMCDEErCbDJIsqS1w34
VzANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQg844RCwIlDk2i0JBOnTnx//MW/jUc
emZq+0LRnmYm+6MwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjEw
MTE1MjE1NTI0WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAJjVOkekNm5U8LDBnKOlM/uqacJ/29zOesFgZBGeJug46QcP
We5dqzIRgoT6CVn/Q/lPTEG+XROqXf3xNiuZq1DnEGP4DvrylNZoXITUjplyo7jxZlm5DwSBOXOh
NUYrif3scr7jQ+SgPqwv1uQ42cSlz6/VUSJb33zpDScfBSnNRsQq7PTFgrHbKP0YVuYLObXRanBe
8mQQQQRXZbCk6IVSogAv/uBkCfVGHsoCe5k0j6l/c4nBB/P3OvzcFbODrN9bmDTeFmRU3awfr0LY
1rCD6pUkSnRzukqitDG5DLILZXTRT1yHlJaE5OTDCUtRgNjNyOuTPr4/DdbyWwxL0g0=
--000000000000eaa17b05b8f76d4e--
