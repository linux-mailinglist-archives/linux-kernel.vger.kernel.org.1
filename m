Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E782F1FCCC8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 13:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgFQLsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 07:48:16 -0400
Received: from sonic314-19.consmr.mail.sg3.yahoo.com ([106.10.240.143]:36214
        "EHLO sonic314-19.consmr.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725894AbgFQLsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 07:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1592394493; bh=KN44s8wdFLI3A6LSzzMJZDE6fBFRLqAQ81FTsE+DBgM=; h=Date:From:Reply-To:Subject:References:From:Subject; b=Fb1ONqWdFN7XRGOU2H5IR6lsTpUiiCr79phyc+u6D6qoBTp4BnvBH0LGrAxhvN8Qc1ObUNWgtGLbwswhmFVPg+7Vn5SK0Clkgevgu0TJdt0dx9EaW0mE2PG7YZAx5Ga0OcSQLw53GflrUuUAxklOirgrwL2wm0LbcLI3xDhTRQcfLSb+Y+PEVVxFJR3+hgcQ8EonHzM2/Z998M++iGrQJLpbGTajNy+1QkTgKmUnzsZhKISeqItxRqfws9dqkPqUpJP86Yo19YwVI1TuZL3Cd0rsp+a8sDwjOanFuu8vzP1AE36ANjtBhXKS/HT3Mr61UWo4PUxYU5DRJymkbrU2ng==
X-YMail-OSG: pObBMYwVM1l__uv6qGDbNiWsHZrMiENAp38KP0nFOpgsQDwyTs4syH4snrhZ6Nq
 BhlpzhCQv_J1l7l34RMpuVvSTRNY_RB28pGY66QPvKumMFfr8MjsyBmE.FhPF96ko60v5HCTyIiy
 XhlNdPadRf9bFIPMABL_WmCLimG_sAwlQHOAiwfBy.X3DyJaRx4PvzsaWjL3CoykjR6EOP6aMyM9
 kwyyX0sDvx1glczx9MfcxkP.XB9NfA5Am8.fTfGmJPxcOFi_kQgGXrh6Xo.YjrHfqEDCBPXSa8Dx
 TpReAtDcmqT0.JdKllBYSE9.fNhRVIizP28w8303TmijPGZtqbX9o.iKonL3bwl.bBXaBmXzHX7Z
 1SKTyAW5itp.vjvyVa0AT2DsLI2XTOe.yZ3Gtl6JLQF_qRLga3LUW.5.BctcyB15fipQEPbix.QN
 dNmAompOD67opOtjA1J80FYhUxmh6fuQ6urXjGctt0d0bEhSO7sIiMUndGfCqqFyLRkERdN1udGO
 HZPNXEZPd4G1B72r.nbkXUVVbvX_joSu39hM1ufMecEm02.LKY.GcdZr.r5sluX4N_GMf6AzOR0v
 D4W7zBagUdJDX.Rg29mzK7xsd2nf03V9mtncFAsAEBH26N9Sk8Zsqj8nIH7KnnqGZ3.sccd0QCwz
 FUDR_9Op8HpmSM72BYguPQtXNZsuXYyN72ob3awEEje0QnFQ3p3bAzCspOCtIHifmXa9.pQRRrye
 uTolSH_lJsQdIKWsUQEb13rLbNGRhODLBT.MrCVQBIfBcsnq6wv_7Twg9UV_w9HKk_su24PUvYtM
 eRlaGcA5Eyt_pOOZgBU5GFw1JSVl9faqy1nt5vEPkDNTHIZHs8s0KihIiH3nkeov1k.fz.rm3qwf
 ueMPReFDerJWdIlqsOy4YGirRmDrmWGkX.1_TKsxACV_ZTbc38vPYrNYQdB9K847es2Zx8aFv2_B
 3JgAnxv0kndv4i3uLMsqICj55QYffXHjvP80TWFyuik6Ng7Dv0Lihsd5B9YhqfNvO1tk7hTsO9CW
 PPdflxryTcDD2QwgxzX.NhRNKNH7_hnEXhlpcsK8U_6XYFoNE5y9vh1XGvGVG35j5wb.AQQsWyOq
 E9W3qZ4HBkhJ9MbP5TRIz1_dnBbBSTpo.1Wuqn9TSz43frWeF_x.f.MY3TrBw2q3WA4lCs5yxzSQ
 QfaewJVx59OS42rFkNNK.QeZvrkecL03pISyH2m6PxMMg5FlAiW2iCKxgeAROTuTHUxRi.V8GP7V
 o2SnxvzbbcUCTjriKGl_E4ngBMQtJj6xzrzmuLSnWRaq1Q3qGW3E7AKiXhvKH7hDTaJctyc2dyhf
 qZQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.sg3.yahoo.com with HTTP; Wed, 17 Jun 2020 11:48:13 +0000
Date:   Wed, 17 Jun 2020 11:48:10 +0000 (UTC)
From:   FRANK <frank_nack_2020@aol.com>
Reply-To: frank_nack_2020@yahoo.com
Message-ID: <1437908441.1854583.1592394490976@mail.yahoo.com>
Subject: URGENT,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1437908441.1854583.1592394490976.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16119 YMailNodin Mozilla/5.0 (Windows NT 5.1; rv:52.0) Gecko/20100101 Firefox/52.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Dear Friend,

How are you today with your family, Hope fine? Please, it=E2=80=99s my grea=
t pleasure to contact you today. I am Mr. Frank Nack a banker by profession=
 from Burkina Faso. Please, I want our bank management to transfer an aband=
oned sum ofUS$7.5M United States Dollars (US$7.5M) into your bank account. =
This business is 100% risk free.

Your share will be 40% while 60% for me. More details will be forwarded to =
you with copy of my bank working ID card, photos and direct phone number im=
mediately I receive your urgent response indicating your interest to handle=
 the business transaction with me.

1) Your Full Name.......................
2) Your Private Telephone Number........
3) Your Receiving Country............

Do reply me urgent with this email address (frank_nack_2020@yahoo.com), (OR=
 +226 51 81 51 94,) for quick spend

Yours Sincerely,
Best Regard.
Mr. Frank Nack
Tell; +226 51 81 51 94,
