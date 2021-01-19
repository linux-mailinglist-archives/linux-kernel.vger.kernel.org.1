Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3322FB11B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 06:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbhASFzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 00:55:52 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:33491 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726991AbhASFRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:17:54 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 7482C1208;
        Tue, 19 Jan 2021 00:16:34 -0500 (EST)
Received: from imap5 ([10.202.2.55])
  by compute2.internal (MEProxy); Tue, 19 Jan 2021 00:16:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mxxn.io; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm1; bh=YDAKd
        F+AcV0IOYUFAl7UZNcNA1Tj/4JTP0p+Ir8b2cI=; b=KyenI5Z9EOV6MU2bX/LAY
        72TWS8wH+xOQdwmizKtzF1TGQ3hDRuQVJqZ/H9KCv2XY1LD7GTKk02rpd0uPZZRC
        sbLiHsmNm3rAZximIWq0aILsQMX3vpgopoh1+ewtJCrK8zO4wu9i63Kde5m6Hvj+
        FmKBiQTc/7q7oCmPBve+HLxR2uDC+TYqjBRRFuZCyB+u3c685efzzUGxOphgI500
        Hx8Jw3BcWtzQ2sd/jpjrUa77TKmAFQIO01qrTkZHURW1hvU3SihCSNrXBaLtXUzA
        WfDnE5LUmdQPBt29tw/IJqLGVG2KVS/JNdGmkt/osBldvCjGKmyPHb0PB5wWAGkE
        g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=YDAKdF+AcV0IOYUFAl7UZNcNA1Tj/4JTP0p+Ir8b2
        cI=; b=EjzOaPNGFlXNxVRpIHMZco6LNPt/pz+0eNp/ED+96YF9dpH/0/54jYWi8
        uq9ISg6T4oZqsLc536ra6RMp6W2fZvnM4BMMvROmTBhkB05OBCE9M0mqx81gg34N
        w5J0Ca97Zv8WU5KbANilo8jM0YO9KY/SykVrmUHgOCBNRVqp7Q/EaekJ2U+EvTjK
        gvezJfwnutIM4hk3Xy3xYSSw/YBWAOyNurZLfqsoSUKzNv1eqhPgBCyzVotCQWnu
        H6/jTFuUa2gsDmiFlMAhXv2bozWIVWaaL0rk2bsH2LJqrhpgnBXj56Mry9RgIePU
        9oow767GPjs1BL9vxbEDpZBuEUnLg==
X-ME-Sender: <xms:MWsGYCZv9KTBdSqsCylgsXj08EQBo46MMBFbCPcV4JSgusfmkEbgrw>
    <xme:MWsGYFaT7YqgLLlywcVJjjcU00RbJVz5U_D5RfBkflgpWU8hrnnNg5RmcNxI3_mEc
    bDNQuMpu08f6huKMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtdelgdejlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepuehlrgkk
    pgfjrhgrshhtnhhikhcuoegslhgriiesmhiggihnrdhioheqnecuggftrfgrthhtvghrnh
    epueetveelffduheefgeeftdfgvedttefhgfekhfekgfdtvdffvefhieetvdefudevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghlrgiise
    hmgiignhdrihho
X-ME-Proxy: <xmx:MWsGYM9XL_gzpMkTHKF9M34xNvq2iU8tnzNHz12NluNP9w7WpBikpQ>
    <xmx:MWsGYErJw-6qEkXFYPQ_C_9aEFyDpwExyoQQiyRDNEJ5_wIKiN0PZw>
    <xmx:MWsGYNr0sIhSi9gRqALqPaYjjnqfAtDt23Q1_RmOGGVk0Ys4PiwvmA>
    <xmx:MmsGYOltsk2PDjvLhxCGR__AZr33vbQ9xtsFQFxpMK2zbl05QJ3njQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B6CF25C0099; Tue, 19 Jan 2021 00:16:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-45-g4839256-fm-20210104.001-g48392560
Mime-Version: 1.0
Message-Id: <d5630b5e-52ec-4fc7-b8f3-ac219d0bfbbb@www.fastmail.com>
In-Reply-To: <b08d641c-3fb5-4845-85f7-e1753149cd7d@www.fastmail.com>
References: <b08d641c-3fb5-4845-85f7-e1753149cd7d@www.fastmail.com>
Date:   Tue, 19 Jan 2021 14:15:58 +0900
From:   =?UTF-8?Q?Bla=C5=BE_Hrastnik?= <blaz@mxxn.io>
To:     "Jean Delvare" <jdelvare@suse.com>,
        "Guenter Roeck" <linux@roeck-us.net>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Cc:     "David Bartley" <andareed@gmail.com>
Subject: Re: hwmon: (nct6683) Support ASRock boards.
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(cc-ing David Bartley, who wrote the MSI patch)

I had a follow-up question: I noticed that support for MSI was added in
December, but there's this conditional that wasn't changed:

	/* Only update pwm values for Mitac boards */
	if (data->customer_id =3D=3D NCT6683_CUSTOMER_ID_MITAC)
		return attr->mode | S_IWUSR;

Should this continue to only apply for Mitac boards, or should it be cha=
nged to
!=3D NCT6683_CUSTOMER_ID_INTEL?

Bla=C5=BE

