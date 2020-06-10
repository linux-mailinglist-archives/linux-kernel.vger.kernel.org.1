Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26C21F4E64
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 08:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgFJGop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 02:44:45 -0400
Received: from sonic316-22.consmr.mail.ne1.yahoo.com ([66.163.187.148]:46205
        "EHLO sonic316-22.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726255AbgFJGoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 02:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1591771483; bh=YdDyVS9QBRPCiN2YYZ/cryZSa6YEXSJJY6ujWZ06LZ8=; h=Date:From:Reply-To:Subject:References:From:Subject; b=jqRZqJdFceDG6vYWifLbws7x6ED4EVQCqrpcbzg2gxAJ/8feOzWdwHfiUn0fIwnupLgpnPHxyf5/CqsFlPvalKUV5WJ7i7qhrgUSihoOZTuvcVTCt5msMhgYNokwZgF8uus32kJyV8PPqvqQqh07yiNplBa+ahnf3Oq6hEuKn0RdNs18+gW3L/+O3Z5fByck+WGCOunrgP/r+TrZMFmeAx3iytpRnG66arIsz5jpdPswdOkbuHKoxCdkRhPKfZSsSv3u9U682Ze7EvuXVzg7+ujuypcC/vgC7z283/P7CMqK5QMY2uHbVPveOedOpoEMFrPiaEOakOKLmcXxI0+aRw==
X-YMail-OSG: mHLnddYVM1mbyXD307VgOxOh2r752aRlOTjBBIr6_5FuQo.r2u5SHbUtY9OVW70
 QBeqSe8H3CEm1cYyuGjwtkDSBXqgcwGsHhuK7Drbi0SphKAzNMFQBsgaZdSLoNgOSzfBu_25KG39
 B46jOBkto29Nm62YxawE_ZGZXrQN57SA_Gex3GPt6ibElhOvADtXA8r8Y7XCj2mSDHqD.B7igSBU
 wnBsDnQmWnyaItEtiMy9JlpH3SeAkg30u6vqNniyFoG4qcQ2dteLi51okXsAfXodPtGeGFqrGU8d
 crgVaCfMBqY0BKNo3QbxKirZezIo5qsmkuhBoXaWsf4K4UPOeXO6Pl7gJGqrjRkaEkpb87cETJZ8
 ypjXZbLuOb23zSgw5fyNPawwAdJcuc6qOlVWpPgd2RWWYSPS_e0.BHpRnHYDzHcePSbwx12sgQQa
 WAppMbzRAUucyGsAcSflRPerfRwxhBHXsA46jM9muKk3rsaMQxxgqi6T6tF0S6Za.ZQT8w9WspHh
 bA.XWmkSjdjw6CcVlohSaqmYRgMttsamguLw572v2Xl80m9hOUAI2dd0ZKY7BRnuMKlUetSBSs8D
 ibIgmIfm.vVjAEtQFjGdUjUYlLMgqT7SSc9FOqRiu_la0FxqjupYZEqThTwibLfcmFqnOC5LVgkR
 mIqh6xotQqWg32e.I87ljDMFGAK0TVlToBthQU.0M75sT_8oRpqNryPA6IxXhnO6bQ.EH0nBcKSw
 M61UcecX3kyWbBXbhwZlLEI5GrhXqzYuwLMw0ZdNjBj74xek02JcrAvVKRRtcZlnsHKG501RsUgi
 b6hJ9A5HJjLTy6AWEDBo6wVIApfPzjw3wjk3aMQi77cGpSOQIubqZPWgwuUph4gZB3VCA6VdnJK7
 l51whcBa_VzarsKLPmcTH2ZbeKaDuhbrkcGafaEsMzGaCoC4fOLjxb9RBG6LeHnbNnBXB93DjltI
 ngWHrAUiWv.ztigvqjVEmMvoQE5sgPC1ZMCiHAvQB.hcXKJRhYyAtkZsWkWiT6moIqGq5OO9W2Re
 dspphovsFpb0xjd2k9U66miYg1xdRWuWb60l5Gu2uCqQNG4oC.s6GlI0Xu5cbXnrV3N3yPdOL1on
 039.OPbkGZMu4lgbWs4Jk3G3M35TgvtKqsuKHZDYDnSwUNWVPa1MfDcxffXTdBZChPR1ENCXKMOd
 KR.pcYPwzW5QVg2A8Yiww3DYdH8Z86cK.Vy91zrzd_ZV1On0hY5e9XMss_e658FuEgOGberWMdjv
 18v1wNM6EVJ9cYZrjefXzl1XbOuaAh5BhNfjIxwToTCAFv7RFe4qku2GUZkaD5ibFLLQzapWMzUr
 xlB5fSQtHOc8ztQRZjWAKbRE8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Wed, 10 Jun 2020 06:44:43 +0000
Date:   Wed, 10 Jun 2020 06:44:42 +0000 (UTC)
From:   Mr Moussa Dauda <mrmoussadauda@gmail.com>
Reply-To: mrmoussadaudaa@gmail.com
Message-ID: <1301434136.2025933.1591771482976@mail.yahoo.com>
Subject: I await your urgent response immediately.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1301434136.2025933.1591771482976.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16072 YMailNodin Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101 Firefox/77.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Dear Good Friend,

Good Day,

I am Mr. Moussa Dauda, Director In charge of Auditing and accounting department of Bank Of Africa, BOA, I hope that you will not betray or expose this trust and confident that i am about to repose on you for the mutual benefit of our both families.

I need your urgent assistance in transferring the sum of TEN MILLION FIVE HUNDRED THOUSAND UNITED STATES DOLLARS, U$10,500.000.00, immediately to your account anywhere you chose.

This is a very highly secret, i will like you to please keep this proposal as a top secret or delete it if you are not interested, upon receipt of your reply, i will send to you more details about this business deal.

I will also direct you on how this deal will be done without any problem; you must understand that this is 100% free from risk.

Therefore my questions are:

1. Can you handle this project?
2. Can I give you this trust?
If yes, get back to me immediately.

Try and get back to me with this my private email address ( mrmoussadaudaa@gmail.com )

I will be waiting to hear from you immediately.

Regards
Mr. Moussa Dauda.
