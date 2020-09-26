Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A07279A8D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 17:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbgIZP4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 11:56:36 -0400
Received: from sonic302-2.consmr.mail.bf2.yahoo.com ([74.6.135.41]:40396 "EHLO
        sonic302-2.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728017AbgIZP4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 11:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1601135795; bh=I64/IkTzvhycuRfirQT/qFA13923FtUz89dqv3KbBT0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=mfKbmSBYbGjf1fVmSqkT7mf7x+B76lueJGgF2am2GOFUL9PKFI9KWpOx+mLde1q8DqrwRfBgvJ93EwlzZZmg7+vDgTGbE3HTHqYHyL3lFp/sGnxSjGSx0etbSN7hZO1VAMw9ZWVJfEMjyAmhD+mWvPnVsgHizDV29pg0OxTKpCvd0GoImfYVZBklwBkefF2d58j1DVVcFwUUwS+R93I13nJOBMX09O3t1d3j1rFvh0nSC3FTk3I3Ph4c5tdnHFpFp/jyfToSAdP0zU8Khc9+JublYbYMv5NBoqI1mMZUUQuXWewfBjHGak9encqsyNwdkQW+ImmtIuoGLkvEt3KukA==
X-YMail-OSG: 190iib4VM1nG72n3qaLPKyQaOgsPbDI_b2uiByhZAcOYOH2vjksamCWuniUIpkW
 CrcWM5SyxtdlxVC4hyWNNC0O_O415PXRuqt0lHWJsnZBktTLDxgcyW13AFqfNogqs9htaI.XTioi
 1nSEk3RvlRjrs6RTMLe0NTJlrGjvzflS5vcFPhIegpSow9cmN8yLPZY_TPJ05LXVNAmcs8AUvYNa
 a69Km3ntnJa6cp761BdCABWXucWD8Ll2yI5j1f7lWMuTAgCMcjQaAYAscbVABuWWU8.uR5sZ32th
 4QFTMBV16OV5iYp2yzgkgZ6eK4e.iswoADNlOgO6.lHjc0z9kuEnCqVkHlVBxRx_zJHi.8TfI6pE
 FXjW_pTuF_.DKXE2QsCD.UVgRPGu6AWlZcnBIY5hX4H3WxBe_9GDyfhyqX5lS0MZD9nNzLvIT0JW
 JMFn6VRrKObNWdjvdFGAH3OMvTKzhcvqM4Jrq24n4IzMCikYMaQ1aIK9JRkA9zdR4MBuQKliao32
 9rh.LrhWNnIkiIG3YbjEpt6dbqPKr8VcCmK89jXymjmG2ud0jRGLzgksoadywZmIJLpTMEdmdJG3
 d9TYNG1iDnsvgkd7_BaCnfa3IiGwuSVWPwAPDvyjc0DKhyIb8f3X24OWXHOaD7OFdpYlAEZIh0TC
 JYye4wQpzscdSl0SryP2b.QBPoZV_AAE6YXz.dvdlQwY7dxVSViM3XN9e1ZtmaE.9UFm1UySHy.t
 29xtmvBuQf8NuKYfoBbmmy.S69IB.LF1HIQRJN6a_v5yuKx635tX_eRlabeWksAMBtwLnXo2TkTg
 FrosSRpjQadsfq0d0PVUxWHn.eaGQLU2aAmU0fICHCTF0Ka.TUwKzZF0tqC8ZNvxj1Y4av_._21d
 b7bDmk5.s0NqINhU_iyDphGQh81g3fKrgjBrSWjeXL67HfK8a9CsyjqvR6n6Jbq0KXqch9hEZ_SV
 PFqh1ANosbQK5RydzUGo0Uil9TJuua.fVVnzPiyU9aV7mtKaCKTmq_X3UVdY3i.XxCgE.32h4N.M
 Fz4fCqMH50ALhF9.zVV9J5e0Ju_KMRfhUyGG9IP4j6Q5qJVC_6FGBihrZljzLnRNdZU1GOR..oiw
 428S.lsc30S9pCRyaGSR1glDmQap9AM5fZt8UiYXAq5Ak5lMAxZS5h.EY0oIy1hP55aRouh.Bnzn
 cwdAZ8K7Ej.yZ_VZ9VMpHFOA18guKPbgl21fr6tTYYCpFYrcuJj_sQ1fE5Z86KpHJBPYW7IfXU2_
 .wtxq_lEb43vDLvOy4qWlPYDumwSlKpwp0P9kKNEAtSGG168wdDvJxEkw7St2UiUQOHVlpurkTlR
 tDqS8JjO6YtMlDJU4yHiFsI7meuF0Ervs_Ss6UDeWNKfiRZsYS2d8IiNoyv2sTs1.ctPGYazPVmz
 7icMezFlaYjA8fe52ldI_h7j4U1E8nqgjmGrVKwHsuFg7pRcobCHE
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Sat, 26 Sep 2020 15:56:35 +0000
Date:   Sat, 26 Sep 2020 15:56:32 +0000 (UTC)
From:   Dr Tijani Ibra <uaedutyfree4@gmail.com>
Reply-To: tijanlibra87@gmail.com
Message-ID: <1555480852.989402.1601135792752@mail.yahoo.com>
Subject: Greetings
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1555480852.989402.1601135792752.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16674 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Greetings,

I wonder why you continue neglecting my emails. Please, acknowledge
the receipt of this message in reference to the subject above as I
intend to send to you the details of the mail. Sometimes, try to check
your spam box because most of these correspondences fall out sometimes
in SPAM folder.

Best regards,

DR. TIJANI IBRA
