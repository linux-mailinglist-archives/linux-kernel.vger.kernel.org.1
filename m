Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8987D254715
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 16:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgH0OiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 10:38:03 -0400
Received: from sonic311-23.consmr.mail.ne1.yahoo.com ([66.163.188.204]:39987
        "EHLO sonic311-23.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727103AbgH0OeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 10:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1598538839; bh=tR25mrJnjckQkQ7xRwOLJYj4gsDsNSUhT0ngblMmrXg=; h=Date:From:Reply-To:Subject:References:From:Subject; b=Z6tk/euGCruWPI+XBQmqoP2p3Yc7FwH5RTYFC1HEZSquUW71SEzzgSQcgE0fIFGmAMcPrFAkQDlnpF+Z6ibu9HWhJatU8qTUuwCbAztH3L4K8boWZG9TZt/usfaOcCQcc4l+xzckpHvxvynWbjZEVGjULnqfwX/DTa0czOrTYOlaYWa9RyOjV00T/PDSFXFm0XjEhYVNoRnLp9AgvlZZvDaF+vHsC23vZSwC4vnS+Qe1RNca4bSaLypXe/+lWSIBVaVpxKprYTadgHWW6x7hD5gMYI+aoehTVrlq/Z18ulWr6IgKH8XBTI13CdapDJ7vjFQupkqNpcRJrZuiEviIcw==
X-YMail-OSG: LLNKKWUVM1l31f6Bpzm5oSJSxmmau9VD0WB1CZOEtevwOMI2XIo6SPGjfq8fIKv
 5b3AtT7fpLfpCzZK23UFMxM5TKyXfwH54YwaWlWTPdTHpKE18OxenGkwB._cHiBPTnPOFydgKMrq
 hlPYaC3cW0VBSJCt.ElIUrDqDlTv53SImaH6DJk8RCQLDZFfZnh7szEQM1HhGIACazFiO9B0hBxX
 .NugeScTE520ZPGpNq_VakF_5TpJQWekh3NZ4Op0IHnC884BQ7ndIevOAWs2fJBvyzm70JYsl.zq
 ivlhF0UDv99N4yIGmt3_o5SBtMTO9_Lvdp17W2A5rWqi_kan38dAbPuzKr2HpxxE8wmytXeC37Q_
 Ywf181nPkYdItsRK7yd0BS4gd.ukkNkAsnG.DxEogC7eSIX9Wi.C2pdGdLuYblK_rBf980f.5.u8
 cR2r3P.KRBCgbKWP3zwHdmrt8t.KwIcPvOY4DY80v9EJel1DkUAkQG2o7OePw.WaShh8kuCl5fl7
 4G__ui4JrlEHpmRhm7llCvDkAYzPxydPZ6dNkb1IdsrI0n4rSbTATm2aDp7SfvHm_cJNtJxkNVi4
 pOgSRoFZuovQ5TbyStQ5R10eNrC7Tc.VTQL06VdBPlN5q1JCg6OGJ3MRiBArTY3zAplVDHfCmWb3
 Pliw6AYpfICumx.cLXzNr4HPiw02ufxcOuAMMjHx_OHISbGiLIT0IdT7NyjQ9HE6Gj3tr8ZgXFc2
 5Lc9geKG1HigsFVvGPG2oUf_jE2NMjcu5EwOT4MISaDXO105MewCObiytdzhJy1.9xGKouJspymA
 sWfEAdHpSOVcH0W9CBarB.Yy7mRiKpaz5Vztx77Y.1ZC7No9IMRglJUWjRDO220KIxBR01OuxgRl
 WvAHobRgk267.DnLmkrtKLaH4w_2M3to5ca4cDl0NmMB1w6VeMqGyWHIjvjVE1ViUl33kVRhL8Z8
 kQY9.0CCQ_S.pp3xmutTTlRqJC8kftfNJ1lvaVSqGHVu3qiPutSzgPowtvfpr9tV6UQZpQupLJgK
 dN6H__yeYStPHX.D_0IKTU7nBKhX4ytw.AMegfNPVIOrB1e7HyFFRtx0czshSvdpfJsRftDunNYm
 QOLOZkaZHPZ.CrVT7u3vRVrMRrjFX73czaSeXjfaS.Haa9O4uT6PkwrrQvTR3OheeTtIB.lmTg8I
 EeTwy96xPzVXbSH_CwvAZZA._mTHYVfCqev3l4kySeIUH5EjxDDwjtXQD4BCIz7c.kA5A_ddaZHf
 c.P4Tyu6ft1E3zWSrtkVdCXiDD3jqmtfU0rIa6FMRi.eedjDiBU8mvgkZvCcVAiXyt7RohljQDn.
 FSaM.v8HNWLIx6LEQJPbMzmX2jR8v9ubhPGBbzpSxe0S4wFgpfckROZUdusawqVFZ50JHPnEceeB
 oJG95rrKvh.jHHA9CK797V350FegrLoDV9xukMTxa2IGUrfM-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Thu, 27 Aug 2020 14:33:59 +0000
Date:   Thu, 27 Aug 2020 14:33:56 +0000 (UTC)
From:   "Mrs. Zainab Madina Chantel Dauda" <mrschantal.sonian.kadi@gmail.com>
Reply-To: mrszainabmadina.golf000@gmail.com
Message-ID: <1618292482.8500642.1598538836379@mail.yahoo.com>
Subject: Peace Of The Lord Be With You And Your Family
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1618292482.8500642.1598538836379.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16455 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peace Of The Lord Be With You And Your Family

 I=E2=80=99am Mrs. Zainab Madina Chantel Dauda, I have been suffering from =
ovarian cancer and the doctor says I have just few periods to leave.I have =
17.5 Million US Dollars in a bank which i want to entrust into your hands t=
o use in helping the orphanage home in your country,=20

But you must assure me that you will take only 40% of the total money and g=
ive the rest 60% to the orphanage home. Contact me with my private email I.=
D [mrszainabmadina.golf000@gmail.com]

Regards,

Mrs. Zainab Madina Chantel Dauda
