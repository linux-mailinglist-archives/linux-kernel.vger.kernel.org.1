Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D65C2E8B48
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 08:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbhACHtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 02:49:25 -0500
Received: from sonic316-48.consmr.mail.bf2.yahoo.com ([74.6.130.222]:43365
        "EHLO sonic316-48.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725294AbhACHtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 02:49:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1609660117; bh=BaJajCBU7sQZX8y4X7Xtaz9qarJnuwTwb8hqNW3MfNs=; h=Date:From:Reply-To:Subject:References:From:Subject; b=G8oMSENc8zPCRhqevoW9qPKMci1NJVnrfCUgGbrwRdowJuUXz7w/x0ZCCTOMvhwjpmfd8j/jyyP6D2z3mpNzN++IL7kU0VtewbFnBZ51pd8raRR5Mys+W/GbGTJV3XHKP1QF7D6pXVSgaQzcgQssK8w0TIfLPOmyApI+GKb5mwbSGcOBRB1f1CqhPEnZK89DGEuYYlEj+4w+z0ExhM05YQYJf5i50UfLYGrAqu4fy6xYpB1EfrPAraP2sRrRUnWQlmfZh7GiHc/mZjHm0rqYE1oOO/O0W5HJOahGLmyFOdhCbaUHuPtxPZt6SpRHXc2C62fi4kuju+2DXDgW7AOGSA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1609660117; bh=ExOJ7rBkq2PGE+865hEl13MVZk9ejtSFKa3o4L1uUcm=; h=Date:From:Subject:From:Subject; b=F+iSuouCi7K1+wKAEOwDkMxgCOIpgt2U1VOoyu8mF66xGUQ3N9G2ya4OzV/0ZJfOodQfn/XyQ/9hS075stWgBYRDx9Ez+R6AZmplFSc6wNBPTE+bl/x3Dbt0LZ1Zr4R0gy7ocllzkzD8W0JeK+JjakmRl6+sZUDdkRmH7QwR+hJZFc48SLxzDaAVwhf4ZaOrugu5mYx+6U05KOBCKQ6WMvmPx+s3/Fo84aavz5PkUlIK8YPzZqFQqfshjXVN+kFzotmcwzAID63Rn5kIbq4CUIbM4GXKTLnkLd72h/J8PtjS1kDmbjNwkmz2CA9eyWxOI7vuQdjxEep99KmQOQYutA==
X-YMail-OSG: Bb4zEREVM1naMd6eLp_a93figCRrkPUCnxdaJ7.RQrQs0BJ753kFCSJq0elODJ2
 pPBFFElgLyKGTgZCgoPuqPSF6r3N7NWzBuUCB1rqqJpqxT3EFhq8htyGdTAEidoGINBzaxyvWCqB
 buczTjlNSKPYiEv3D0fdUQlylS7X1.H4WnNDTn9pfhgIHBX28bC7LYjC_HqiV5cZ57FWIIqBv4yN
 a7usn9obW.TWZlA8dyqDybvZmF20i_OA0eX244B_Hd__JvN8fzoEPNxW8YX0XHHGcKNPHljIYV9S
 88tQl3rf_KTY83QSTZoaqb_rXgRBWi3GtPQ0CyIEFDXW28fniYVvdWcJfJT3NYd_6neBZivXApB4
 ZFG5_oGzNqFFZmmqBlDiWW2twl8af2JU3SXaMZYo3awGWSxaWD7uITqj9hKAYNpQ5GviB8WhY2_b
 jJ4mpfPKhw8T0oYfqolgmHI.RwBcUoUFk.R3fimcHIhllAC_9BkdzinP52NWeDirhYfp4q62y_nV
 CIAoDNMCyFkAg9z96Ru2txYYUEibKcO3a89Lhfux.MzUY0K5HiTojqqtUX7DmCB2y1aFy1QqFGQE
 VD9kTZLnJ0bPLXVQrUvurubRIthy.8wsJQWyl4Ix5xrano3Jrccmhhb0.Ld0T_8uRRqAru1bSg8G
 rqAOThzjHI7RnwywznKxZ0G_FyOea9NCU.4EMT_P4wLkJMgyC5oijWuU.nznS.OjY5ckDNAJJp2k
 SX9.7laFXvwt3Pxu4PYe_NsC5Vzou7PPCydR6h_0P3Bt35Bfrhmz.PXxVCCHJa5NhOdNVMZaXTri
 BUf5zLyzU5EKAUVgJaNmScfROTv_D8WolaKi1u86Imm74xe0Bdh17OxBCi9qntRccV.gXx.YyGge
 zOIgA2tIDcE0PI7WJRCEJ4xzJRRH4H8AQ.6pSfOpr2jpqjWLJ1wWvUOQk4VSc9tZz7yb_wrL3qit
 VH269gFT5KORD4tb4gp45DoTaIgjLNAUuJqvG3vIZskgqUYzVcuRWdh_5Es0EKjkzNMaUNa_PzGA
 6O5ITfKzXnknsEeHiC.z0Y_rGgSD8xIUzOlFXDZbwhYok4ThhYI9wf6uioVn9.wBRvvQ3Y5kRzhQ
 2oHG63jFiVysFoGaRi6aFW29jlF0tElhWqENxkJfqg0C4VC.a9rI0uV0fz6yGjmpgKDy84m5mAGL
 MMsKyBZ.AgJWx2On3ZHygTaE5Yoq8udEouiJJ6PT9u.IjdWcqEnJFyg0UdhyTYQbKbpEHoBh81W8
 J7p0EyvyOzqOdaBthNHvRa952UZ3CApYTE5IWWat8Sh6XeFPfR8ypOC8fnToGdGij3TkZqgjlrAI
 PuTwFXPjrgtDZcw0nyJoJj7ddjKNopLialO3YlYBsZGmzjfrtTMdV2Rh3TuICDxDtUcG_ssH2J8c
 GYZxktjyfFJBThEdFuCFz_rN793eLHK1R3Pn07S33Ilv0eQZ__a0e.9kPKb6u6iPncu4wrGLqBGu
 CIB1UswJZKQfZRvNGXVp1vEBR5YDQD48_MAzXVAJvT7wOlNCA3JNJ4TDbZP7S..TbHedgneBVCKG
 MfdLO8ySBBmRRQ4abGvgmZYUpy.yHFSXzfiev0QaZH6.qNuWyb.3g79OZi4JqoZpgZDaP5jqNU46
 ShqcqV18GNkUf5TVfg7GOKsKSv4LXaM8_2COk0YxxyToaAfIyOTEsieIGVw4WiRyB9c3P8qUsCzr
 iXK_bTEZ8nqSRmb_4vaV2pE6GIcASgF8w5lN0w8TBoyO2uw2AXtVwOB5vTu24Nj7r3kE_h788CYP
 ciHKWXiSg9HzPZzgpGjzBGNYsekk.0YNtaymn69win.q4kx3BBndt0nYN.jq9XT.7fweQnsJgwsC
 2z2kI1XB3BmSEYT6GBi0JnfohHb0C1B9fyyVK3mViKBVuVs4izi4zEybBvx5Wl6oyM6jTlAG.s7P
 xoVh6yRnzBbFWXjAtpaqndu2eqcU9wa3BoI79qYT.kW23hzCbQfzwV6.dwZqLuH7B4508UXCYGnY
 JdEQAIEbWiwid1tWVoKFoSlIiz6IDrqC84bJMUQHu1t8iwvRAfKyyGif9r6KY90UEIXuNsD8xY.q
 C95xmnihrxndU7M.qIdM0WOPGoR5xghVIB8s0R_yFiyq8Amtjw.5NWjKur.BIm6qQvZTUZkU1zV7
 KUq4xBQDUIP1CKXygDbPu926xlwoSh1YklW4lUDuJWaZqX.ZDEVRTjMAJ.0fZtFdJNnG8BlfWN7o
 TYa8i7oIB.E1YDxPDrQNqnwnSR4gYEvK2vAf.fBmf4DMJK.TmfmjM0Z_ECtOUn7gZATYVkkyJ1Me
 idIO.4.05n9qVBglFpYpd0vt.IbqiyRLzh_NekZDGofImpGkV7tV0Ys0KFPqi.x4GjNySMbUPQaa
 KGcz2z9cEojxn44GiBwn89kVoXnJU53FjKcxA4hVlwOzdKW9sP6iAlgBEIo1QfZGY94VmZZLPWvf
 ezoYtVmc4sqcLr.THpndIdTMEkv.RrbnBFLzsOgJt4mpxn3p_o5BtoOR4FSXOZuutYS0dlBYDh8C
 ig8ZPLW77wE41DvDx7pl3jOGWFipun_Ag7Fk4Poy6S5qxp8j5GnBWuPQq5BCzto52n2P3svrwhlz
 pCbfg0TBit9kqLnN5x90AunvNvdEG.fROnsrYDlzhiHWGPoe2idtnRmvfpSoBBr.bFrd4Tt101LI
 YsZloTJWloj1mdNlAG9LimBysgQLROR9jkhDAFVXcdX9._9eiDO3DXqp1eBQRQ58whVyyIgYiryP
 qqE49zCq5WaLStu2rL7BqRvCMYG9GdkQoSkWYkhmnucpRGABgJUOBrRLZ21dCq4hN9YRS5dcBCvg
 M0Kmz8o8twGD.bgwCF6K7kuCra4ndQFVzaMyvOdYtubmOpO7rggPJtju_9dKKRzNLMKBWGT8j4g_
 6XtVyguDInQGHOoWgJZp3vEM_.VsfDF0S2clgd9CNKxC5bH8E2TGce1UzgqHjAIQxvoSmpXIXQfx
 If2PYgevBtYmdk0YGLySjZwZ3CPutzrV6MukDkSElMdcz_5396B2dLSJQ_ResumABF.sNWTygHaG
 agRXwWBBznhRpnqCRK74JcVbbyG6oyUA92o4_cVw2JW5VNOCvRlO0Schha1UkRG8mUIpWuI4gO8S
 9iuGjUjQVKg5._rQm6B8CqAdvqHZF42M7Oy1XZDUn6lqNFU8gaSuCUvMHIQe5DxHy9eYvDPDZpKk
 MyyH5ErkxHAjYHbZbHKW_pPKnlN0Dro6_.0X57IC5kYMrm38t_BY2oPhz9zRkbJ0PX1auvhokesY
 oKNg9apIVndykDQ_AJcCDV007KEyMKH9EGJLgsaflwPsolJAHhlIodRPnT6oOq8JmMrOmkINIaXH
 igb_IEPZQqAm6jhPGclhUfvEkQK_VfvVxgz5TrsC_z.hM3Y0bx4LB3.ja68ZU94RZlQn049oVojn
 c0GwHJ3tpY_Bhu1ZvrYGK9GKQLgChYgc5YCAfm4krA5NuLxiue6tJ7gxJcqOfmwBm2Me7keH7.Cf
 2_9mlZq1h82hWAG.D9eMh.jc.OYqreZ9BcGuLXTar3gRncKvGALowGsMncEagat.iO.hFKrtc5sI
 bV1R5xthrly4Fff_G2qtYNmmbhqkZswA3M.83uDmJc1kAoecw5Y1CEyvkrwWuR3DkP66P3mowm7_
 09pqktiarB.dbimjxdRRcaFDMsAoYxoTlcuvgjUWMiPHIvNN4xQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Sun, 3 Jan 2021 07:48:37 +0000
Date:   Sun, 3 Jan 2021 07:46:36 +0000 (UTC)
From:   Stephen <stp05@ghxlo.in>
Reply-To: listephen573@gmail.com
Message-ID: <531168079.3990362.1609659996944@mail.yahoo.com>
Subject: Greetings
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <531168079.3990362.1609659996944.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.17278 YMailNodin Mozilla/5.0 (Windows NT 6.1; WOW64; rv:30.0) Gecko/20100101 Firefox/30.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Greetings
I was searching through a local business directory when I found your
profile. I am Soliciting On-Behalf of my private client who is interested in given out big loans to high profile individuals who are interested in a serious business investment or has a valid business, investment or project he/she wants to pump more cash into, as we know the pandemic has destroyed so many finances so if you are interested in needing any loan get to me for more details. Your swift response is highly needed. Please Contact Email: listephen573@gmail.com

Sincerely
Stephen Li
