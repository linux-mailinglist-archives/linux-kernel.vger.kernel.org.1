Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53DF71EF15B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 08:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgFEGdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jun 2020 02:33:15 -0400
Received: from sonic305-1.consmr.mail.bf2.yahoo.com ([74.6.133.40]:34137 "EHLO
        sonic305-1.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725280AbgFEGdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 02:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1591338793; bh=T+HL8b202M5prJrGoveqOp5+tc3db6bJ+vH0TMitLlA=; h=Date:From:Reply-To:Subject:References:From:Subject; b=fjdUTO1d+7JH3xdmXsK6EcKKqWiqbi5Yy+TeeQW+zgqBPphnb/05cEJ7DYSq1LCcfKGhDTsYSBQjX/4AoKB3Ysy9Y7EV3yiIVw7EqmnMDEw+1PcPTI2Pqsd7u0Tm/9yYNiwZL4a54lSy+M/iU7rr1lyaRtT303ztuVQvnH5tIAjbBp36stoCkPrZy5gxwkyfggtAt1s9jY8obk/kKH05AB6Cqn2c97kC03HVqECnmbV6CpzVLwKAT+/tbtRHbTAuGx0fX29aWaQ0cct/UmXBAB3cIEy/XV6+SMyiAr/AZeer1cT8vq+TymaaFnWh7TajjtYNPmf8iiCPsLJ8HKGngg==
X-YMail-OSG: 9VrzQvgVM1lTQ6jz_WOxuuHyqOcZ5HewN1xmcUlkXRqffpSGvHF6DpisKC69Guc
 x5H65dJR_gU5X.sBctBLXHI___COuQcpJY3R2fqTUc47x72HjiF9poXKabRHrUyDtzEGHgBOF3BE
 XkajANCVifNLZzCTmmpYUffTJtxFSxbF.DxnYrtXKjRDE6S.A6_SJgA8Fhs8OQqiQKGTfT1eIcdp
 KVZlV11gd.5zxhHPEibqSQxIWRx7oKvUk6mNwmpBApR1UHx2i_rGpy42vDBItNNZ8U5CUqpoZ5bn
 wHWTJeBDz7T0HAC2DzsBYu84.OQL49fwCQ._px4nozrACZ7yl0vu6q0oXtfCUIJPp7ZLv1MOfquW
 Fmfd8EmSH8sxiBf38oGT6cllVrRd9Q5vvdLQ_AaDYC6uFxaGnaWzw1tPfNJgkNe9bD2o0YIuwwg3
 y1sqb1jFQJMOfrOAqNDhaSdc94UDv1qiOsz.Oku6whALpDXBvoKbMt6GIOOj.1JbU0WJa6Mwedw2
 BfXRNrAInf0LMMqyYXlObbrB20J8d4VP.qHAnssCDQjyLaHGLZlbxsgHTlFl9O296z.RcOuOBMmo
 rhofnX8vsgszBM_BZYnl5zuBBt0THz5.HgDInCaVcIBj3sB51YjMtQXLR1YiiOcwKtoQBlEQ.kgG
 nhgN4Dl.Scz75PS0fnFWSPoZf0TxcTnYEMuKiJPo2l3BpHeqX9a4ByPS5dhMozfEN8TFXy3ZdvYi
 TGOHZivUhM_hj0VhtZeMDvQuXy89s56ipg9kW_aqF797DH5fme3b9baCNP.2HVZXedFMkOVmCMKR
 imhi5TMY6AiztVedcJN0gF8Ylu0EhXCytvXbZjAi74uVuVyWv1gSluZspEsxi6lsfrOV.Fse1c97
 JHKsNMme3xm9ruafq6jLe0fT4iulvSdcXjlLCoB3k9.HtA3OvLJqHYfU.8UCRS9NOt8g2k3.12E0
 hKXN._Hu7nEnvupJ1tvxA9prS8v5CGDeH0ceUluKxDTny0eTZOz75XjZURQpSdZWSWY1kT8LtPO5
 8ieAgPRdSPrSqvr8_Vvp4.7yHFLSPLPncckJhQuMPKsBVC8iDufaJwWjYKMmbuC4QaMaq.njlj2I
 Cy6X7GuV4N4L4X7o.ScgkMAj09gF44R4DEHYStdidXfYSdM3aJn_mcyCEeEgEzLfXV9T6Gj2teA3
 DIAGtb1jjx3c_Sr7bjuXSjREL_b3b8OwCq1oK4r6QXZghvylfIkvRprZluW_9004cTH3S0a5WgGi
 1Ro3gXhqz5ZT6wEk2CG0VRg8CAKCdhqMPBCQjNQJ4PpAua0Rh0OT15J3HxONwCLfBbDYXr9p0XhB
 E
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Fri, 5 Jun 2020 06:33:13 +0000
Date:   Fri, 5 Jun 2020 06:33:11 +0000 (UTC)
From:   Mrs Suzara Maling Wan <mrssuzaramalingwan12@gmail.com>
Reply-To: mrssuzaramalingwan2@gmail.com
Message-ID: <637424962.2155286.1591338791209@mail.yahoo.com>
Subject: Hello
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <637424962.2155286.1591338791209.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16037 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:77.0) Gecko/20100101 Firefox/77.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello
I'm "Mrs Suzara Maling Wan" married to Mr. Wan( an International
Contractor and Oil Merchant/ jointly in Exposition of Agro  Equipment
) who died in  Burkina Faso attack,  i am 64 years old and diagnosed
of cancer for about 2 years ago  and my husband informed me that he
deposited the sum of (14.3Million USD Only) with a Finance house) in
UAGADOUGOU BURKINA FASO.

I want you to help me to use this money  for a charity project before
I die, for the Poor, Less-privileged and  ORPHANAGES in
your country.  Please kindly respond

quickly for further details.

Yours fairly friend,
Mrs Suzara Maling Wan
