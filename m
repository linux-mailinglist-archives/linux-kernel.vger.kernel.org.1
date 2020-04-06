Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E47219F36B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 12:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgDFKUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 06:20:31 -0400
Received: from sonic307-1.consmr.mail.bf2.yahoo.com ([74.6.134.40]:43770 "EHLO
        sonic307-1.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726675AbgDFKUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 06:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1586168429; bh=NajTNMrfMLb6UXcjRhYpYerQX8PtVBLz0oFgaMINSWY=; h=Date:From:Reply-To:Subject:References:From:Subject; b=KO4j4dDCKDvGuKhsC3TKjiLg+tfsHqHsWpwUydwhIahR+IMnPfXEVUz5GTdY1ZblPuJ/s9yQODv8oKpabQKHS8V8PsEdhZDfjgeEvj4NKLDvGRgtIxugZt8H5e8Fy6JzHv6w9+7Jq0bXUHgoq+vvqfODS+simf9lSa2+/Xaj2DE7BbIMFwa2OeyelSyZC77r9e5ZbvMmX1Pf6paDJ5eOGullPirXk+uk+xdgT0K4lrrwTc/5be1jtsxw1owjhlBVRtqjvvkIewz0XiOjBPeZBCBV2Tmjf7mVejJ+vESNwSuIWL40yfYbhwelO9cBqt7Fe0gVRMeB/4U486K3/eGZHA==
X-YMail-OSG: hugKqDcVM1kSGaYjmRoIRctJzrbl7YTJjQ1reERdmRpqIzOpAWrzoaFDeyi5tMD
 0xxWflP.aWVwO03850b5XagigEmEVVBxj2JckXFZJYMXZ342C8mK_bSp179l.y77lzeMO7SsyM9v
 53UWvw8LKhkf4cm1L9mAEDuhxlJY8vtzl4poCvdx5pUxb7NFiyvDoR_CxtxpMKwYEO2Qq3Ok4w_q
 18Tk1AbI5.o3.J7Jwcay.zz68.AW4qkyCndR8O585DgbeypCa0IlT_IiYqUcby.Fn9rPgJ4ydC1z
 9o6pwldILjpcqHmUWyWuWvdpyV06VZp6cYY0d4cTMX1wlwl5lBFH.tydC5ynUXABwlZHUz1GGrAS
 8FhbM_kALxRNeJDZ_0vyqVHD_Bo.98AoJo.86_4oVZ3umZoRqa4M92uLA0b_Fxpy79CjS8bZLjBm
 CUoloeX9PKIcJ3lTRY8VRGltWFhoWRfQF9VKMlxMoKYiO3tcCmaINMuU0lrrMldvasV7G2nHADPW
 UOT9tvBeUHIvohdoRxGxWPEJhMDl6CMuwAZdS671t9fv2hBXHb8MvSuTiTr8NQWKG_7dnQsWWV1Q
 M5qbJUvobC0KlwcKBWEIEUTHd5ztTKvYz2mKqODsfY_Uc_318NdzS1Nu7GV_SdAfMCOhJRR5mEtZ
 aWPuvGDPiUGAT4G.fpntgRxGs38rWeApGOksxLNdSSZaKd7Jhy6cU1vuVKyWRYzlAk7BaGZm363T
 RC7gO.uGZ009zbP3Kd01QuYXu_j1qKZcEYy2sxBRsgBi94_vOapOSOzGWStneKIpw5yFMhoYjWqB
 UE_3R8Rxq1KdWx55K7ETD_Ze.gPJbktITIrlgFSj_XF4I2AAP0NUD_Nre0LV6h2G6v197ol.nqMW
 rVBFmmp8UiZecOKdXaiUuFyJH2N6RPq3UNBSfcQ.ZZFz8ilYDg4lPwFmTNc2FEZygOUfNzlnePlh
 zUHK_w1_F50r3mt_tTnvJ2bteH.juxK0r8GEslnrx5Oy3fpGc64pHUO_P96Sef3.VitnxYrgqhdp
 k3gwfnPb70OEM4WGVT5p6BUV9Fqba3ubCpAndXbXHRojou0MKAij.ug.Auz4VsmblYxDMNJuStOG
 do2rgqTlBGke2lh9Dk_CjQfWa06ot89JDhC4OBt8RI4zdJ2rD6uoUFJnmFZToZ4zHha0H4DgPzIv
 OyqeuCzZSsHIBZ86CW8WMosNl8Gk7Y1.BLyJyhYlIOfpVddepEkHQGyExCIuI_S1u1DsLpGvnBos
 DXrjSuPP.BDOh9GIJOtuoj1DD5TJ1EccGvjw4VQMqaVGHHGYIXB1I1gzP80Kcg_9X_bIUwu8iWJU
 dSNZE
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Mon, 6 Apr 2020 10:20:29 +0000
Date:   Mon, 6 Apr 2020 10:20:25 +0000 (UTC)
From:   Ms lisa Hugh <lisahugh531@gmail.com>
Reply-To: ms.lisahugh000@gmail.com
Message-ID: <420241816.731242.1586168425523@mail.yahoo.com>
Subject: MASSAGE FROM MS LISA HUGH >>BUSINESS
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <420241816.731242.1586168425523.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15620 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:74.0) Gecko/20100101 Firefox/74.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Dear Friend,

I am Ms Lisa hugh, work with the department of Audit and accounting manager here in the Bank(B.O.A).

Please i need your assistance for the transferring of thIs fund to your bank account for both of us benefit for life time investment, amount (US$4.5M DOLLARS).

I have every inquiry details to make the bank believe you and release the fund in within 5 banking working days with your full co-operation with me for success.

Note/ 50% for you why 50% for me after success of the transfer to your bank account.

Below information is what i need from you so will can be reaching each other

1)Full name ...
2)Private telephone number...
3)Age...
4)Nationality...
5)Occupation ...


Thanks.

Ms Lisa hugh.
