Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FAE2A141A
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 09:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgJaICX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 04:02:23 -0400
Received: from sonic316-48.consmr.mail.bf2.yahoo.com ([74.6.130.222]:42095
        "EHLO sonic316-48.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725832AbgJaICW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 04:02:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604131341; bh=gMLxQyNorYFZ5mfjImfGxhuGiI9T1cObZNJmFWunVqk=; h=Date:From:Reply-To:Subject:References:From:Subject; b=eVl2Aw+pLPCts/NvhR6pd5fhKCwmit5hdEr/1JOJNICquOG2vr2a19bSzGhnhBwkvUx9SrXV3rgFMZD+YqShQZ8Lzi0gdhln4F+f76bhZc/S2Mcx1ry3wudDorwTjVFPtUJhKekDg2h+PdZBFhN9mINZdcE02AAVRsFuBJNZe1uRhyoCcZ8X4MX/qxgHeI3pXesDssn205/CD8BBpGd7E6lZY58pV8k9fZPtSx1gWWtU3LiTqvx6mAufmIDQnFo9g9jn0jlBfvDf6HOyzPJXI/ESCc5XIuxSG401vMwb+qsRrecpDmqg0vi7RaNDqjTp2joal1xW0tPPiq2dP/mCnA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604131341; bh=6e5Jv9JrGLPdF07yDZDeHaj1/7Ri8I3Jj+nx0BXLoCF=; h=Date:From:Subject; b=BcNEPIhHgZRk7EtyyWdhPFOYsjthhoBARLts3PmVuGMNA539OOPMjQSyNacOMl+1VWGPFbk8dO1Cxl/MUCwUL6GWITtlcZB7hOlut4VQOdR5cvKLJzGxJYBIRPvnx/H06G1kH4LtMZU84f/jMtsmCh6Kz9DWVxzWXJ0oW5tvbT4l/oR5xnVewsD3Ycao+VV+0nCZ5Z5C8HT5/GHNz/YbdYaxOI08WhpzQYCWY+2B/+fpt17mhTOMBgCtD5SOhZsUEO/MyMrRNzOKaO4/rDqSk00aeFmzMburS4zXCEjYtfONskA4r0v+zssw7FDPkuRVNlgCp7r5h6iGLVwyY/qWBg==
X-YMail-OSG: SKm7LMcVM1naFlJe_wll909Yo.72rmSWX8tQvqZL9Re5R_wJX1xxZG3kjnTGzTN
 2dSIw77ZulBxMK226kEK2QmT8FvulAS4h5uRo5MVvK1CCs9FczGgORQmH3RjwZGThZvDco1R6l8U
 dnAAYi6oTKr__OLLxjNHcw3VII7YygygfXxN9r9EEGiLBbkGrUpOIJ.Xc7zONtBa.ScCPLsZpXQU
 bMAzFuJ9EZ55LdtkVdAoSbLwsk6c68h71XXSqjU.RCaP8wXL02yphVI3e3xibc2iaRBVw9i2xpz6
 ZVM53XJFxM7D9yHscvRqg6xO85iSFM5IZwWQ7wgo3Sekk3YrNurknrOmrQFxQH5fxI48Zk2Hwugc
 HPI6RYlkPNARPx3KyrPCEQ1DBdF1FpRggfBKKGcdJozUIYjm4ndBsifKPZhkX3hqoU4kLfQjxnJT
 TucjH7T71_On70BidbQVYnhGtqxqmm9VaNTZeGkyBvqIKzIi2bVRekUpL1a4f6Wd7x2_yDnrdcuH
 OPT3euWgR0hwPdcPUMnA5n2yNKaB9Gd7EB01rYAt3Gpq4e2YQb5.jPrzUEN.KmklG0k2WsSDFVtv
 Wg_4xs3BPvW6uvS3iaMpZpwu4b0ah7M_D6Ik7Z0oXWObRq7_2P2e6jF8C48hiEA8r.qliHBj7fAk
 ZB8cZoAlZoiSJW8fUdWY6VLx8iO0tZyo0dvrBYb4rOhnWQWwAQrRcYFTmmBJc5Tu4d2lJ3zgNRCi
 0nMvhglLs5Xw92x7qlzweGs3el4nA3MCJktiDdnGPPEINM_C.EJj_RZzPcYT1z1AUeaBQAmvCrY3
 jK2BdVOQz2buq7pF4QbSaBQq0p160jIzCJ5B_oNB2eTcBpJV5shNOx5jK0Brh8.62BqcRsKDd8h3
 Td0o2lguIwXX2eSGyPo54s2WaejEbbBEHlAYr3Ddh5qOFfNMVhUbJZPzsYnbpEaEFRLT5Q828i1b
 ndxZCePwIWdMEb6UU_UO22xZM4poZIWbCFbGrziGJEX2_hku6lrtEhdvNaHWP9bQ6zf5Yb4P1avp
 UjXhnBmIVwQbfjDBdvOT6Ax66UesOSK3sAtZ5eMOrHEGD_Zs5YZM1fAJ1ETlENyAopok.5W_oLvM
 hayyiBX47sQZ5XVaSizNGeI.QoWAhBK33V29d4RR9HqXLzuS7F4bqQwqSUhQ2wNHBjGBNdE5JW.J
 JmFejPtZVc3Vj576z93bwJ4zxE5y9FzFfG1lEqxxNFI3Lz.dePir_E1gnMqz.xGuo73_T3MqB675
 GM5wf5EYuWl3a4ocROpcAASzr9klPH6IXLOD6FIn0QVJtKTDIF67oD9TXSV4TB9aLhiIZSGSQXgw
 pbw3VfEmUeJ7wjRXC4kEI3q8HyNiTUmeLKHWz_T9RGAZA2PDSS8Rt4HyU5GCHSzDY7Q5xN_uwE0J
 14fp5CJ8nR0xppVG7Vp5c2GS674eGtBjMImPg7XdQuTeMiCTXhBGjhV0N2hzYAkOUANYYZKzeXvw
 cV.RT9XWIeC_OhfMmE7YL6VodYjMu7dZ305bl0KJOueNgXPiL2Vepxg_wN211jWdL0LVelC5zKqU
 OK5E_XXQD918L69YO4OGbcdxsSUt5wnv5qwCOusWNtBBXdCFcc4WPGiLS84tqFhqM37.qSz_smLn
 k_hnltM2fLlpt8aKTao83Vrj2hQc2el.kQJ76JYYOQeu0ZEQdUswsQm27VGTZJzBEdt16nPHLgIt
 38_o4qPNX10z.w5W6NRy_6inHIzxC7f1WSGADmUek5wZooSeMn3Ul5LRUo..piOfnTqLvst_OUrp
 MC_HQsBudS9jDHGEo7odDsy64R5kNl9vuCNwrfQbxFkyGB1URTF8oEWrg0mQw9s2jAABlKAjI_M8
 rIC4IvQ90h682rGt0OyDjubmPYWed3jDlZsEB.AgosVLxgR0z6wur2Kbn0F6BqTL87auy41D5eho
 lcGxu_k5IxbKyizHhTIvBa6uizbMXweFJLZVcHiVQtdD7t4REGZru19kE.9p7loN8SaJYUc12fvl
 3rqlD0hx4ee1fgN6dckhuzDnQpIEYgKSPuSoVj.eXMPw_LmVXWQBcM1MGm6hhxGdYWY1B42zu2jZ
 LCNu52GxwS4niWo9JcufRFNNX8EShkRDDN48lA8Y_rIH9kplurt7uilKvIatF2kLtzsns6pz_H2Q
 znycDU6497V1DYTr_D1M2i4gxFqx7..hEGxsMrgrfMOBLWYl_bBchtZs9EZ7LqQ_eGJv4A_FIDtP
 wsAKjJMF2lu7Ems5OUvcPm_02jf1CqMEh7kXBRSiGoGLcUgRyoY0SqUk0nn1PkLSdWbgbePIc3Wi
 a39d6flqVZfgqADSIV_M_qMN3EFjK0igQY9tIGMELtHCy1yw4.0yh1nlC4B.ZhQtJbG3z7tOcsb1
 RMQKYO7h190hzrasxMHyaCcpLEja9fwOoJr.0fl1iQYoADGgFLRijJTlWjfQy9niwHeoA6EKedpH
 oDCpVUZLRTHDKX55qbuepfZOcPvpSmfmUXn8j0k0p0HpfU.WEsxNqs9CCrw6LGvIKVq8DGliukWn
 reyTY_bqeLaRZD0Krvj8FuA2laTkCUxHRjYLpdN97yeO6Byo9wkVBqr0YWT1XHndYSJs3cObiShq
 RK4QtIaQLCUSGAVV1e_xe75Th85FBWGIhQasgPa0xVs_3YBml2_2TQ7A7ianU4l1WZN9YiUoACX1
 j1LmPIbuk0fredXQrtSBxSqd8vRw_nJn1_COY5Ro9Vt1r0_bUI2eJREBtFbIvpH1myHXVF.tXBHB
 yPLNkNl7.ferGvpCbuMnwJI_5j7fWHNc2Gh6zn8SNIary4mXEBYEpO8XxGlTcyT1pNNQDflGgZxz
 kRs2r8NFm.YdXzc7LbLpC_QfMbuvchu6em5_M7tpqiV1hAsB2C9jfb73yz.NCYU6MguyjiiM0pV6
 XElWShHMLU8fqv1zIzkBzCwp9KLt79Pah.dJWyYYEMp0vbulWhP3iiK_urHNm9uAPEgArR6Yj.kJ
 2k2O8XtsH23ZOvvcyGWX8q05d3EyzlPqfH1XQeaxzLpC8j2IPj5LdeLsxNL7P8Qz47GnDwMSZ0DI
 MY5Kfvg_H0z7Vfu1j5.5ProdvEdkO6Tz5526b0XJa5ZjgUZ61NyXNqQqh.gaJQU.xZqRl1W5W3Uc
 zuSqE5Art3ZxW1c5sseqxkS6S2qOPYvJ_2uqaFLIv6C22ViUFlZNbEEF7kkD3Z0448qfsJ1gqbJV
 My6j6uiJbOGm..fSNpR8OhBlS4xgzP2oqNAjnExGnuX9iO9LN.3qooZ8eb_ba6K5XzLneMKqfNG7
 lNkpSTJ9RKUcUCGLW0bqBh878qhM1JMPrmL7bsM3L.izWsGuZptOcUHteB121bARvmO7_Of.Hx1k
 i62gppAYkjU54yEcFy9NAIp8zsaAUIvYmAo_iju6V6nLMQAWoAbFixMG1ln_uOyp1SmJBAncEXUP
 4n9RvrzTxMpxEBhXNXVwpDQcWG96.YRNQQFpa2zhJNfxITf1gz65GKJ8qWn3tc17DzqVuJwQBnVX
 8iiwkYIPgDK1U8zNvVxREgqz3l1LiCrpUnFFhz.m3qGE71YnyTSxHhpEjCx5ybd4OeX_C3TsdU9L
 gcDIgw30LR64XeLUs3SoLVTQdwd8_tvOhENNRvsuh_OtdMI8hvNBKoT.aEFA-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Sat, 31 Oct 2020 08:02:21 +0000
Date:   Sat, 31 Oct 2020 08:00:20 +0000 (UTC)
From:   Mrs Margret <webpot40@gfcbd.in>
Reply-To: margretnelson564@gmail.com
Message-ID: <708509309.565464.1604131220421@mail.yahoo.com>
Subject: Urgent Responses
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <708509309.565464.1604131220421.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16944 YMailNodin Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



God will bless you as you fulfilled my wish

Good day

My name is Mrs. Margret Nelson. I am a dying woman who has decided to donate what I have to the Charities. I am 85 years old and was diagnosed with cancer about four years ago, immediately after the death of my husband; I have been touched to donate from what I have inherited from my late husband for the good work rather than allow his relatives to use my husband's hard earned fund.

As I lay on my sick bed, I want you to help me in carrying out my last wish on earth which will be very profitable to you. I want to WILL a total sum of $5.5 million to you which I want you to distribute part of it to any charity home for me and the rest for your family which I will inform you on how to share all, please for further information contact me ASAP.

Best Regards,
Mrs. Margret Nelson
