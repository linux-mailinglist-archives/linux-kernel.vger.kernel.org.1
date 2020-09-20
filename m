Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559F0271627
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 19:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgITRAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 13:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgITRAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 13:00:14 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA46C061755
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 10:00:13 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a17so10339048wrn.6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 10:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aus.edu; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=jOy8pCEvDvUVsY7c+dPWpcPOlK4T09BoZC0Ovrp+G58=;
        b=DBHC7IKKSVH01+nHHdBW0Wp0bft7zE16WjPNV8gVjZ4/iDYLymkvYgfh9P//8f+Qpn
         OnE8U24HlUsqHzpU/E/Ek+IM75Ob1Q5ouYcg2rCQmobTSttvdCQCGDUDWEoAFS+qyprG
         LHuPvH3nTXhL7twIm2TwlUtc9chK8XiLasUVIAHkP57WAwVB+lvVAP1/8iHUmfYC+MNG
         KCtBUZ3r9xGvrquNVSV4ZBIwT1DFRdHuSCdiR301iNyFZ5uQ+VVSWPmsQmEi1cDH4Yrl
         d/LKNLM1IAjHS5M6+/RGiGr1X0xc+mCoxAhQJwUmKuITr6QXbamPohoAK5Lm5STnMU4b
         4COg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=jOy8pCEvDvUVsY7c+dPWpcPOlK4T09BoZC0Ovrp+G58=;
        b=WsnuM1gFSltUAKfSo+izx+HLEYQBmRSfN41YxGWlM7TmxHuBYi8TbFamimH7kwjB8E
         WPcojgzgv/qjRYCa1R4asEMsfT8xRI02V/Wr5zsMQMxClEFXSWBtzZEP8Gl2J2KLMHi4
         iN7+lf9oTSQFtjHLqqctfQ/rlqv6alunVipgJ/mGLgK78RsLY95OCEPZrAIaQKG7Wr1m
         vu1pmAl3j9sTU2mcfFcJ3gHgIEaQw5uOZKcwQjIzFWn/OLzI7p5NFPGqvA+mQqKWfyxv
         6s9i+eN7jAtueEtnu9GrqgoTobF0A9yjLRV8obeQko+bnf3Nbv6NmWlIdTqQZBF5E6yE
         lq8A==
X-Gm-Message-State: AOAM533B25vyYqIOxVn4wqgZ9BrTPkWvScRsGgmjHOI9tj9aXtCrSiEP
        9lgR3YzeBVSMYVOVV35kA/j8i0kvSzUa+jRIRuZ3zO0+4ALOFAcEdzU1FiqhC5zMKF8HjSvbdEI
        Cq+DxD5r7owjjtZNGbBe9N/1kCpqldeozHbljYHmMg1VVuD3DhNUp3XwZpq/ingz+TqMnDLIgxq
        s=
X-Google-Smtp-Source: ABdhPJwM03l3cpdbOnDJvxPxLpecxdRj7HYc5iJIcn5OxMWFNGbq0WLbsiAY0GHarOTgo3hmB4SPqw==
X-Received: by 2002:a5d:6404:: with SMTP id z4mr50798032wru.423.1600621212104;
        Sun, 20 Sep 2020 10:00:12 -0700 (PDT)
Received: from localhost.localdomain ([2001:8f8:1461:1f22:70ac:7893:ce11:b470])
        by smtp.gmail.com with ESMTPSA id v17sm18002592wrc.23.2020.09.20.10.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2020 10:00:11 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Asif Rasheed <b00073877@aus.edu>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] Staging list.h: Modified comment
Date:   Sun, 20 Sep 2020 21:00:09 +0400
Message-Id: <2634BEC0-93C5-4630-AC27-9A0BD56641D0@aus.edu>
References: <20200920151822.GA29330@paulmck-ThinkPad-P72>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20200920151822.GA29330@paulmck-ThinkPad-P72>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (18A373)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everything looks good. Thank you!

Regards,
Asif Rasheed

> On 20 Sep 2020, at 7:18 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> =EF=BB=BFOn Sun, Sep 20, 2020 at 05:31:54PM +0400, Asif Rasheed wrote:
>> We (everyone from my Operating System Lecture Section) were confused on w=
hether the list is circular or not (because no one bothered to look at the i=
mplementation). Modified the comment on top for clarification.
>>=20
>> Signed-off-by: Asif Rasheed <b00073877@aus.edu>
>=20
> Good point!  "Simple" here means "not complex", but given the size of
> this file, one could argue that this characterization is long obsolete.
>=20
> I queued your patch for v5.11, but as usual could not resist the
> urge to edit the commit log.  Could you please review the version
> below to make sure that I did not mess anything up?
>=20
>                            Thanx, Paul
>=20
> ------------------------------------------------------------------------
>=20
> commit 8ac8c191b5f1a42b02462d5b35675f2439097b86
> Author: Asif Rasheed <b00073877@aus.edu>
> Date:   Sun Sep 20 17:31:54 2020 +0400
>=20
>    list.h: Update comment to explicitly note circular lists
>=20
>    The students in the Operating System Lecture Section at the
>    American University of Sharjah were confused by the header comment
>    in include/linux/list.h, which says "Simple doubly linked list
>    implementation".  This comment means "simple" as in "not complex",
>    but "simple" is often used in this context to mean "not circular".
>    This commit therefore avoids this ambiguity by explicitly calling out
>    "circular".
>=20
>    Signed-off-by: Asif Rasheed <b00073877@aus.edu>
>    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>=20
> diff --git a/include/linux/list.h b/include/linux/list.h
> index 0d0d17a..796975c 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -9,7 +9,7 @@
> #include <linux/kernel.h>
>=20
> /*
> - * Simple doubly linked list implementation.
> + * Circular doubly linked list implementation.
>  *
>  * Some of the internal functions ("__xxx") are useful when
>  * manipulating whole lists rather than single entries, as
