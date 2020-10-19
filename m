Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACBEA292EBF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 21:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731150AbgJSTrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 15:47:32 -0400
Received: from sonic309-21.consmr.mail.ne1.yahoo.com ([66.163.184.147]:41062
        "EHLO sonic309-21.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728228AbgJSTrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 15:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1603136851; bh=wMqcY+1+xzZpq40CBU4bY3tP7WHdEhFlqGtQtFHhz5U=; h=Date:From:Reply-To:Subject:References:From:Subject; b=r17DO8AD3L8WNj6hAKcum/nlKK3gIylBdp0ZR/KkfLu1XopYsw6GSDPCLyZTpAI88d3SgVuHkn3SBJ31SwgXrOs7ZjOIoKMk+YBjkrWHxyR5IRv14TX08T1OBgidU9Hjyv7cNHjXHBgx9fs7M6joV55t4E+hOcWQ8RGsTCheMTTUiRqPcjwbYiBs7TYdxUnYpLv0oMsm0OAHQPVAcQUD7DbS9ZBsx75lDbYmylfB9TEud+rZW3kxJrOvHerBdCyAMboBwInKZHa4TCvebJIlidoL5qAJgxarwjxqrmebhW9Kau6hW/CYoDeBvUPekXG0wkqi3SPCdF+vY820xiHWwg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1603136851; bh=xErx/nqwuisZhbKdJ6VXgRUzhx6MddOmTa2fKZzS6B0=; h=Date:From:Subject; b=EWp2sf4fbKAHDoUMD/gbvKMAPefKxQ5Xn1ilMH281+GSCSrkmw08VpWgAGbBy+fqXIljcjak+CuGAAJnZZQgPDPGU0zif91RMOcLTtCn1ffZk5OfbCiq+vBoqLGiP3PMFmG31jD3URgWsVYIFm+74t/eftQjCb026kXhCk2FwmJykBT+L8RkgiQX5ft9Fvis4S/OaMwg96uxjF/QtcJ2qrEkLsQJUBoAz10uKX+p8+YG6Qzvj7+5ZHMMpqlrsep6S9Kkp9zs1v+jJanf+BTZTCA8bzEuA7TmZiJb8AJjD+kwrJv+WDjT9Ufy3Q3x2CQ6oNTrA58FyM45NxbUON24RQ==
X-YMail-OSG: fIVXydgVM1l6Pz9LA12j8JlEvpzRLTcPyPcTy2By_gfjHxO_b.QaMnU6QLZqNxz
 vtQH6xZlRVmmAuUZtdL4Yf1ZT5yMSq3iDFXDk1y0jZqtggzC1nCbu6C.AY1JMzen6ObdEAeHTlfN
 DQfCR1psL7xZ1T_EX7iw.vBxnSyGxHfjHjRN15pPJ2ThZ476FQsMH.DggCVRtuzlNlT5ozj2IZwT
 DmEXmdJYO0oRR_bgLae.RsGquKBur56CC_5rk6saenHJnBIAa85hBsQkKfqUe7D1pRjWBeH2F.sN
 K0nSOixY2t4YOtfp_lxPzIDmS.EEqfBSSjrFcXm83lO68pC8cN3oScAYiQD_oD0DyDd3z5FNEEH.
 3aW7xUJqdHw5CcJ9INTYhGZlZ7ajjXyp5QTVL_HDoNV4FavJM5CK1.xoF6OOacep3Lx0u.HAfzq_
 bZTp_X6nz26O5SLNXT45.72UIok3LHDe8_VcHxn_t4UJHqcGRRVxBt7XcqoZCx3Y4KvrpkfWTwF6
 CoGErC4Tw61gWFZ_dYSk9lFh3TRP1k1GMZvZk2u8Z6razUuBK6ouyGiCMpv6H2Caekv_IEdcUJmK
 ROQKhQoi.4CXQwXVw451Cz1LMmBuiPhNtOE3kog_gQIu98nEIaNG7LKyUpcDrn_UWKy0HPaCfk.w
 J47nKEpfssbGCvfuhxHGkcCPZHx4dqaTTQK8UvFYQHXGR_M.jmay40Ij5dmrF1LWATscHJWIjlVe
 ppaYuySKwiaiVF6iml83iUZjiWPUMF4IhP4aa9u2emAdeFGVi1XRNAExhlDspT8AMNSJsjRLWoxO
 Ve5Ci4Ez6XorZpRGHCzdvxDwjVF_3UqpRGtYy8aXZq7lxmmjC5Ubt9asQ9oxfC.QDDrAjlp1T6ka
 z7RcejfGBwwYozF8w8X5.ovdToI5ECVAT5Rk8zcIwS7ikHyf5YUUVeREpS3a.C1zOnpy5hUXYFIu
 CmWnnTQ5jvq8uhGCyL4Bbk0KdppOXaoG2BmsNN3FSfDHq3JEZlsyuK4pBaVKGv3wdSzbaw67gHRZ
 3s3toiZlZoP0rsa3A0IIVpUxV5GlVuWnG7s_LVJHN60OubTx4ARz9ell7DCecVCFwRKcsfEY0adt
 EsHfrQfNSkrPBhftGGDbpfXVVg7fvGLhKvuqa3tcPpf1TDN1VAR3gmDu8wqo.W_ymL3aPYva1Hc4
 TKDgfuYODeqaGfDf1IYqY9HYI1LImXTZBc6KU54G6xB14_b5h6Oxj9HpxiXGw7Tknp0Ve93TK7T2
 5viqExdB77cIXlx6ff6qdTF.bVBII3pQu_5._sdBWOC6clJGWzFnsN7ukW5aAprD17wRmEx1hq5B
 iGxaSOzNQkkzOe2_CfU94edvRqG2TLhXVy4jC51nOMieIeBpdNDvlYLrGYHZmP_ogrI2gcM69L_C
 VFRdiTAv.OoGaUSPTbcmWNFqgkne2XIHtHWna29rmG7bgL4vnd9Plr23VY05hUiYW6XXVXBmZfaA
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Mon, 19 Oct 2020 19:47:31 +0000
Date:   Mon, 19 Oct 2020 19:47:29 +0000 (UTC)
From:   CUSTOMER CENTER <customercenter739@gmail.com>
Reply-To: customercenter739@gmail.com
Message-ID: <1464613815.1194965.1603136849633@mail.yahoo.com>
Subject: Greetings to you
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1464613815.1194965.1603136849633.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16868 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:79.0) Gecko/20100101 Firefox/79.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Greetings to you
We are writing this letter to you from LinkedIn Company we know that
this message may come to you as a surprise you have
been selected as our new-branch manager in your country; for more
about the position reply us via this E-mail:
(info.customer01@consultant.com)The position cannot stop your business
or the work you are doing already.
Regards.Mr.Jeff.
Whatsapp +16205060599
