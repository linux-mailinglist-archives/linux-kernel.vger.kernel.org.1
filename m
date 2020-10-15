Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C4C28ECD3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 07:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgJOFo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 01:44:27 -0400
Received: from sonic304-56.consmr.mail.bf2.yahoo.com ([74.6.128.31]:36644 "EHLO
        sonic304-56.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727397AbgJOFo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 01:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602740666; bh=MWL01jPVJXuBFzguUnxzZVCMkBAhTvIWLeZZqdlFV60=; h=Date:From:Reply-To:Subject:References:From:Subject; b=bWsVRGn54MYajbdvf+w9oPTcPSBOoLuFy9mrlKFm8pEJ8Q5Ixvcd0GAbm2+wBN2ytA5YoYNZ87HBtUTn27GL6JZZ4KwcYjIhvTKJrDwv9GiX7VKb8Hl5pppQiRocpffEEDs1ezmY+XJlaIiZxjQ3u4XFJ7lWtbGdN6B+xUSc1EEyvM3er+5Z7ejk+f0PM+qm2V3T4rF12w89bsgLlm+b5m3gJ78d/sxvxe26m0hOKcqo/d7tCJFQAeUkLBAodSwNaeo7Pb2SPpE1WY2PiwFr+ixhYmYE+yIXgPzqsrCc84lWHtLWwTNx1AYeQKxkB0xx0tqY+jw6JWpR44aq2NxzLg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602740666; bh=wpR/r7arqBoEFrup2Vx/HL57ScI8GOh4qoZ3EyktEny=; h=Date:From:Subject; b=B6U4kbxj5a2xfI876stv7A0leQoDnrWKPwwyOxoLROxx98SaUpE/Rl9Ui2At3aK4kJyyZZ3nhVMfZEcaN36pviYV/JC/0PoF6UR9xcyhzRKcumxO5WeohIoKi6GKPOWKEHcayoPPmnoj62b4koB7VcHN04OqyKnDRsjtbjIut2LrVK1ar6b9Z/PQYOqzzxFxDHiB+eTTGjnXhbdJ06mq41yG2TEEM7hv0WeWZQ9Ey40LYlAgxzL7+e484QpDiPoRkFvD/UhREZUcWFTWEiBLNMNEYm9cR6HtlF77ACp7PB2O+ush4vERVmVrMPgOF3MuMspEWAfyIgmF/3NxzCKctg==
X-YMail-OSG: OlS5k38VM1kx8b9lhEKMsCjJ0pbK.as3wh8OYt2FSpTurLGbvPBKSxL.3jDE5MX
 eodHDa16LqoKpDHQwuAOQD1wgOUICIDSU5eQVDNqKguPArVNEjgQZ.kD.0xYrxs1c_9FMlBZp5yg
 KLuwdKyFBTrx.CxOk9gmaXvTizyxqnCT0UyFRupzSejhFVwhL2phm6y6pjvjPzWotbH7f31ifbkJ
 wxs3oqjCmP5mCaV3He0rbpB4NkV5aYnjO9ejljyCii0DoAj4sK8EatxVyu38dIHkIsKlF0VNmYBp
 c_OuWjmOSBeYDyhTi6ZIxH.6e7eZF2yvuC2RZyp_RCNO5yhMskPpYdGLpZ5TdzE85rtAQh3ZFlhZ
 UZyrNLd9w2anVAVKEvoa2lMy9YiTXnw.H5dTe6SfaTMZ5fqrRedPDFQ2N_oxeAz1Gom9IqdAJWs3
 pmZLMttPVMdgNdH6O5TNOtlZJ4yzIZdMhZ2bSA0_BHf9UWPy4jhoX3AWBzQ6wnz753P5079J9pht
 9R4h1Itmy.PUnrIBH3IGrRMHSCiX6lWEeg5hoKH4dkC7E1zhKSfzyhX47_iavhCz3_RihQdncMiO
 Dv9naXj.jf_5fW5nmI1xwYaBTm84Ukkyqktjkv_Akg7aF8z33r68XURdxAbQB_eEjt8BjSs0Dj0F
 LBtp5JlPSE9tK2f2cu6D_gIFzfrfDS99Yq9ymzWR3y.EatmxFvLVnRkbFhSt2KNV_tiBJ6oXw1cL
 AotHFThWeW3sYyoGVFi03l6u_WDhYNLM9.zA6rimXsx.3RnoCUk7X4ufgn0jnnF5dxa2exrGMlt2
 TlWIsCvdipB__1qN_s4tBPdEsD7eZEkKHsocyxv9f4D_k.QiR4MamGPlKfcRLwOQKUG4YuziKQAT
 5Qwo4DPjY3YS1f.ZxsEC1WFZeu.TngPna.b15EnNntmfE.LTxgLUm2m6oaVRwFLlZaggcj74BgJB
 X40enUBpi3SBaT0k9xWtBeGwva3nLuhHA8qElerkpyMnim2J_XInqVuTfPgsrf_5bKhdTOwB_xVF
 qpc_NFXGI9GmFKvXxRjYGD6hld7F3HJlgpqqfI1qQ89XVnQ5rt1rWo28RNxsPc8Tj3xVR36bl3tc
 fVaQHxvijBJQvye7YxocfzeRIlIb41BhKLyeU9Vn4pK1GKe3lNJ58fyapftiFny_p8tR3Ed6KI1n
 MTmLpphuGh0qn5z8cJzHVv0i6Pgmsm6GALEUIo8xcojJEv3dHfMZWN5gO4GaDWuTs2gdlOZj2dV.
 Ezpge829Nzll2i7HV5e8AhLpf3XP6S_exO1yYm5WZ7i.c9_vcWbmp8.ZMKO7ShX_v9g2l5MnzsOp
 mxMj1U1WKpk.YI41q5ATmDITgzFiMGLNnvf6NQ8W.3uwJlldRy7hDAO1FNGtcgR7TVR09a37y2_A
 Nlaif.Hrf7k2owPDRYnEmNwAkqlxwgMcjj.rB3r5qIWyRjg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Thu, 15 Oct 2020 05:44:26 +0000
Date:   Thu, 15 Oct 2020 05:44:21 +0000 (UTC)
From:   Mrs m compola <mmrsgrorvinte@gmail.com>
Reply-To: mcompola444@gmail.com
Message-ID: <832039170.649404.1602740661947@mail.yahoo.com>
Subject: Dear Friend, My present internet connection is very slow in case
 you
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <832039170.649404.1602740661947.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16845 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Dear Friend, My present internet connection is very slow in case you
received my email in your spam

How are you today?.With due respect to your person and much sincerity
of purpose,Well it is a pleasure to contact you on this regard and i
pray that this will turn out to be everlasting relationship for both
of us. However it's just my urgent need for a Foreign partner that
made me to contact you for this Transaction,I got your contact from
internet, while searching for a reliable someone that I can go into
partnership with. I am Mrs.mcompola, from BURKINA FASO, West
Africa .Presently i work in the Bank as bill and exchange manager.

I have the opportunity of transferring the left over fund $5.4 Million
us dollars of one of my Bank clients who died in the collapsing of the
world trade center on september 11th 2001.I have placed this fund to
and escrow account without name of beneficiary.i will use my position
here in the bank to effect a hitch free transfer of the fund to your
bank account and there will be no trace.

I agree that 40% of this money will be for you as my foriegn
partner,50% for me while 10% will be for the expenses that will occur
in this transaction .If you are really interested in my proposal
further details of the Transfer will be forwarded unto you as soon as
I receive your willingness mail for successful transfer.

Yours Faithfully,
mrs.mcompola333@gmail.com
