Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7C91F41B8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 19:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731401AbgFIRHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 13:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbgFIRHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:07:12 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF4DC05BD1E;
        Tue,  9 Jun 2020 10:07:11 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j10so22166477wrw.8;
        Tue, 09 Jun 2020 10:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=FFaxvaEcnrm6UjOkHIPoKrcymTAUzbkHGefbPj9c1Mc=;
        b=CBNlTVpy+nciQRlGVV4ObjppOr3AeMjkZzzIoO0NiqJltrhuNP3PvhXeI0Xq5HholE
         UWGSMSh1pmJz3HmdWHJo7uF81GE61w47TGquWLVEF4YgLYWbxaiVto2zCfUsbYiCqC7Y
         KJptq5Qctuno0EBJMuTSgD48MWKilFeg1tznFkMPLhVjOj+9zFK53C+btAG+xdvnq87T
         sVyl2rOvaQ0cGjv3QG3xqBXUPIjW+8rWZWsAnz03zeyODEYmonyxraG+qNv1mjEC8hsI
         mb5bwTzVaLfUydsh0tfcpaJzpg720HmN1kjp5bvXfujRe9l+PT/WvHXN7oN28VcXqASp
         NbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=FFaxvaEcnrm6UjOkHIPoKrcymTAUzbkHGefbPj9c1Mc=;
        b=J4uVkD/LtnlHkgYfZSl6FM6COqoxVBBDuUrXLnQ1hNzgIRAYy7XOu5twNSJrGDUQrH
         sWZ0YLD2dwl0ihiUxz3poAUy8cPrCoLN2eWRCb3Sh8qRsioQBxvaTjRY2MD6g+eq1j9E
         vrsivBu4FxsbBzuyIcxGj36nCUODUVnXrDIKEsfYtdoJCqOT57KEPgdpKaGqSaQFejDh
         L5/DIUiPSSF6f18gmXt29rZ79Dh/+NH8Tc8mRgHxbhoy/4dPJf0EHBq9sdQa/qpLOsmY
         UqNvmnnAgHCeF3YkpDBq+8rHj9L95ueDiVNR6BpI+oX3YGtym3uQRDaggYvhBDZ4LxlV
         ulUw==
X-Gm-Message-State: AOAM5308u+d2kh16SeMLEONiRAayoHN9M3CNtbUVjy479XJafQirHoUH
        ubiGzkWdz/FMf0KcItSpCqA=
X-Google-Smtp-Source: ABdhPJx5FmsR6jieGQu1bscU8ucZ7dIkb4GYGXmSTogxEmmSNi/HgJPUVB0mpMg2BICT8oo5EUSO1g==
X-Received: by 2002:adf:e2ce:: with SMTP id d14mr5590827wrj.415.1591722430308;
        Tue, 09 Jun 2020 10:07:10 -0700 (PDT)
Received: from [192.168.68.104] ([89.237.74.3])
        by smtp.gmail.com with ESMTPSA id y5sm4354958wrs.63.2020.06.09.10.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 10:07:09 -0700 (PDT)
Date:   Tue, 09 Jun 2020 20:07:06 +0300
User-Agent: K-9 Mail for Android
In-Reply-To: <20200609164213.bshzpfuqgioyvtpm@linutronix.de>
References: <cover.1587675252.git.zanussi@kernel.org> <6d4c92b28c54d8ca687c29043562de943a373547.1587675252.git.zanussi@kernel.org> <CAGi-RUKn6k98H5v9kw7je1MChb4+Uq8EGhKO0nuXNMBy9M1_qw@mail.gmail.com> <b5026121af44601e4318479194357fdb956982f6.camel@kernel.org> <20200609154741.5kesuvl7txz4s3yu@linutronix.de> <e288ef193f743782df48667b6b03122bd025119f.camel@kernel.org> <20200609163446.efp76qbjzkbtl7nk@linutronix.de> <D6892A4E-18F7-4EB7-BA09-BD4DF9079BDE@gmail.com> <34E6C220-A85B-4296-AB8E-62DE6D9DC561@gmail.com> <20200609164213.bshzpfuqgioyvtpm@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RT 1/2] tasklet: Address a race resulting in double-enqueue
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     Tom Zanussi <zanussi@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Zhang Xiao <xiao.zhang@windriver.com>
From:   Ramon Fried <rfried.dev@gmail.com>
Message-ID: <61D63A44-E3D9-4E7F-BE08-B887C078F445@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On June 9, 2020 7:42:13 PM GMT+03:00, Sebastian Andrzej Siewior <bigeasy@l=
inutronix=2Ede> wrote:
>On 2020-06-09 19:40:03 [+0300], Ramon Fried wrote:
>> Correction=2E normal kernel is running with RT enabled, crash kernel
>without=2E=20
>
>no RT and no SMP in your crash kernel? So this information in your
>first
>email would have saved me some time=E2=80=A6
Indeed
 I'm truly sorry, I thought our crash kernel is configured as RT as well=
=2E=20
so, as I understand, if I build the RT kernel without preempt enabled I ca=
n hit this bug?=20
>
>Sebastian

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
