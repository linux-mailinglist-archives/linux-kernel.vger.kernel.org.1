Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7E22CA62B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391673AbgLAOrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:47:08 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44957 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389033AbgLAOrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:47:06 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id AFE3A5C006B;
        Tue,  1 Dec 2020 09:46:00 -0500 (EST)
Received: from imap10 ([10.202.2.60])
  by compute2.internal (MEProxy); Tue, 01 Dec 2020 09:46:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dend.ro; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm1; bh=85l2M
        AxVO7AspqtA/I2Qxy1X6dlakXgMUJlYcMaJ5IQ=; b=KPXzuAPyTkteIVkGL+kKm
        5p9yV0H7pwSBf+nx68duReJhMN5WK/Acb2RWksJ9tM0xTPTxcbbLOmjUu3Gwa2mD
        hwMt74L50q5MRjdNdYbcje6YZYR4a9aKOv64V9Pt3QBA0OS9MGYAGWp+EwPB5iGb
        OD1oXXk8NOx7xv/6H2L7OZAAPaiDXDCn1CDg6Rr8WwAOTzKJxNj3/yRDkxthj8At
        eR+Z+W8r3coxMM4/kq52A6hqHk4zIjpb3h8uk+VI6EcEUIomy0Nahueap55rsnjn
        QBq1wSgUAczZPwsZS6E/pW+3w7YE++KwAL/MhKtI1YMhG8bwH8cHYxi+imeyeGTL
        w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=85l2MAxVO7AspqtA/I2Qxy1X6dlakXgMUJlYcMaJ5
        IQ=; b=bK1MNBgXv12gNnG9KHthYEYCdM8X558E2GAVXfH3UB3+MKJB8GcCNoD7q
        cSA69jFTXfHRqJaRJCSksTU+TlzrdYZxm3clJpstKutEPGjg6cdch+dRPucqZljB
        RSQlwi7Gw6dRXucQH1vk2uInkSW3LQ17vUqfvABStet7fyPlNXZ09+YHzkJPwLII
        RsaRoMHqbkMHpyXYAphOJbA9twnl/7Jvyfe51rSw0G7mQZIsdZlU7RG2grCJBuRN
        zRQ3H9hh5zuAfsf4BYvBr3sfnXzP6PQhzF1Czq5rtZTj7WRyZnkSfpcjp0k3eCnd
        RgSiL/0k0eqsuRw5rFOrJzVhqCGeA==
X-ME-Sender: <xms:J1fGX-EMnUEBWYmTqMLaA3GgACBLkiWLivexRFoiV5rdwa-YTQLLqw>
    <xme:J1fGX_W90k6OYuN8VVmLmtC4pnIR7CkeWheh1DlMPPc_fcZKsGze8t5v68R0cusNC
    HE6j9CbK4IbFT2R-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeivddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpefnrghu
    rhgvnhhtihhupgfpihgtohhlrgcuoehlnhhitgholhgrseguvghnugdrrhhoqeenucggtf
    frrghtthgvrhhnpeeigfejueegtdetgefftdduieehiedvtdetgfdtjeevudeghedvtdeu
    uedvuddukeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehlnhhitgholhgrseguvghnugdrrhho
X-ME-Proxy: <xmx:J1fGX4JXoXFs9PETXJ28xVONEsNAY67VaCXDDb8kUIHgsle51f0hVA>
    <xmx:J1fGX4F6DAOys3Z_yTnXCqeDPumVHmeb_yXScImw2hzp5kEGdJ4j4Q>
    <xmx:J1fGX0XTj4sheDr4zafaVvVEWIdpqT-xC5jjfRdKeChLnWSF6zoHDw>
    <xmx:KFfGXyzPbUO1igIvF68dhN9ikwcmQjErg1v1gDoVhw0eWXYvED91cg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B93C1201BD; Tue,  1 Dec 2020 09:45:59 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-622-g4a97c0b-fm-20201115.001-g4a97c0b3
Mime-Version: 1.0
Message-Id: <66fba38b-73a9-4596-83ee-e0ec9a4ffffa@www.fastmail.com>
In-Reply-To: <dd42cc78-bef0-907c-ffa5-e8b8f29ef363@amd.com>
References: <20201126074734.12664-1-lnicola@dend.ro>
 <875z5rk68z.fsf@nanos.tec.linutronix.de>
 <ea40c3e8-0be1-4783-ba1e-86c96cf8e4af@www.fastmail.com>
 <87lfeiiy10.fsf@nanos.tec.linutronix.de>
 <96085c8a-b144-4fd3-b1fb-45763b5b64a4@www.fastmail.com>
 <87tut6h10u.fsf@nanos.tec.linutronix.de>
 <dd42cc78-bef0-907c-ffa5-e8b8f29ef363@amd.com>
Date:   Tue, 01 Dec 2020 16:44:55 +0200
From:   =?UTF-8?Q?Lauren=C8=9Biu_Nicola?= <lnicola@dend.ro>
To:     "Tom Lendacky" <thomas.lendacky@amd.com>,
        "Thomas Gleixner" <tglx@linutronix.de>
Cc:     mingo@kernel.org, bp@alien8.de, x86@kernel.org, trivial@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/irq: Lower unhandled irq error severity
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020, at 16:36, Tom Lendacky wrote:
>=20
> Thomas has reported this to me previously and I have reported it to ou=
r
> BIOS team. That previously reported problem has been fixed in BIOS, bu=
t
> I'm not sure at what AGESA level the fix will be rolled out.
>=20
> @Lauren=C8=9Biu, what is the exact model of the processor you are runn=
ing?

It's a Ryzen 5950X with a B550 motherboard (AGESA V2 PI 1.1.0.0 Patch C)=
.

Lauren=C8=9Biu
