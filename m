Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A611ABEFF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 13:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632977AbgDPLUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 07:20:32 -0400
Received: from sonic312-20.consmr.mail.bf2.yahoo.com ([74.6.128.82]:41632 "EHLO
        sonic312-20.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2632844AbgDPLTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1587035934; bh=85FejEn00gIkX4TgTiJo2MrF+4KusxIBycp5MFD4a0Q=; h=Date:From:Reply-To:Subject:References:From:Subject; b=BqkB/vBZ98OAwAxOsZqWTMw2zuBGxmnVMnB5CsCu5lP6W8qF4Qqds5Oaqdds3+6RRxJQ0PLKGbbEhDC9Y7kzZI0w0h35IsTBqCDxbrThB8vjFdtvL8gmtt9Fcx4ZWq0elN5o9guvfwJnu1K48laqfi5LfZMFGh8gFiHS2Ffh2FYm6JyhBrUX4zocLVVWQdOhaS7AdxjDeZfHqize1oisk7Lx2NGcxoB/69gvyi7ZDUYqNzlRtEOe/mqmRWMfE//SyqjZZHoTc+vm1iYcWlTRP6hNKsceMF1YL9AK+xv8+sfPk+dBNbvUCSwFKgndTbyDAFRqximEvbsoVQToll3Sgw==
X-YMail-OSG: 3QP1XIEVM1mjcZ1ixmJZr7ejTNX8FH8JomIgjcfnWbHjRdp.Ld2pm50e5.AD8.K
 lIjIgjIUu80xtsNJvx7AlMOhmN2O.YOykQ84DJS0SXg6ifAZR_KAcYG3T7qRLbP8mNyDnw1_2wgq
 3h6j0MkGX50cdtXB3_tRVC4oH9siEjyjrtZstgDcJvffNF0HKew0huj.kehTMQSxXvCe4hek.m9q
 .U2k.jfCuC3eN5098Jh3y4Gnmj9JIkA__6VPq7e41PV3OR_nZqsQXgAE2vO9P7i.mMvz7XwEUmz5
 HirWZM7Ulvws5aGE1JvAgMPPJMoaslrWKyXIsovy6Tu4PNVNzQkgqLozQkEfSgO57stER8B1ZsS1
 5.BkvoF3z5tmZJJwXQxQtOhmvKAjbq3XDvc4t2GCRqqSafq2mjpEbt5oOjUZV8_.JWVmz.AT6Bwz
 s.7WMQpUOtjS3W6dGlvRDkE5ERei7ZLBhYMlfLoeySsJrvyl7hExOiAlEr5z4uTSzKvOdG.G4IP_
 r4yixBqkgpl9Xpa7Rn8TQp.i2YhV0GB.Bb133xGBFpgikUJg0V9eIbWNc3l9GXeY_Sm3ITPURZzV
 HcGQe.SAPHc0Si7sV.2O7IU1QGmTKF1cYZ1ZW.dG0uMmYieYB_VuBvQX85VXWxS362Fbjc23FyS4
 vTrERV_aQB2gW92dUF9BfdOT0D3C.2dP7L3LhY2oBEj0SRJI4R7CXJxF5pE4m4GH7NsN9yZPJl7A
 Nm9cBT0gIXGWbuDLjC9M3OWWsNNAo5VoeFWhh3sWgv4Ax4ezXbWG3KXsb8Jp7EaYh_vRErvQPxqc
 JS8HqgzP081fzfYg.MTLIclwP3XrlyVYJGo3OOLCTWNZvW0E6A5MsugmbC9t7H8Ih326tLCAozD0
 OP0Pn8MZjNc9GwdQE9Afp_PTUZKgPISQ4FH2Yp.F7XvwSq3Bc7C5_c0B0eIilCYnkHXkEaEBDuQE
 OIZFh0T_xvrbee9a1whm_1PH2hnqTghh4jE9Yo4cyaZ4o7s15cKVRTMuEBRVsY12CDFSnLOn.xSR
 Tt8UMtuBip8f1CdoHdyr.Vw90P288thFnScVXq30wPNvMa3Ie7LYVO6.7bJutSCyCf.XQJr5EXGh
 xl4wJEZ7c2m2NqzV7Df2eU82Cc2AzHtiikyULP6xXeGHBjURtFo.4HkjvgNWSJEQoOIMeoXljZ7h
 GYqHzX1jS06Imb_xcP.JZUftqvKc6axPct0NKKH2x1X_zJU8mBoY.gILyhcYGI4c5VjOf6njV55L
 mQQFVvQgIEqv6uNTyKIUI8lPuG0F2ppZHhQzJT2DcIbkxxuQCVJU7.EThXGx35EWGPk_adcRWNe9
 4S8wyFiQJZZXBe2ejxJGGyxxuu6OHD6kik3ogZfh5HP45fx4aYK00Ygc-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.bf2.yahoo.com with HTTP; Thu, 16 Apr 2020 11:18:54 +0000
Date:   Thu, 16 Apr 2020 10:56:52 +0000 (UTC)
From:   Lisa Mikerriding <lisamikerriding8@gmail.com>
Reply-To: lisamikerriding8@gmail.com
Message-ID: <939866598.976795.1587034612271@mail.yahoo.com>
Subject: DEAR: FRIEND.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <939866598.976795.1587034612271.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15651 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



DEAR: FRIEND.

My name is Lisa Mikerriding I am sending this brief letter to solicit your support and partnership to transfer $10.5 million US Dollars. This money belongs to my late father Mike Riddering, my father and my mother were among those that were killed on 2016 terrorist attack at Splendid Hotel Ouagadougou Burkina Faso, my mother did not die instantly but she later gave up at the hospital.

we are from USA but reside in Burkina Faso, my father is an American missionary, before my father died with my mother at Splendid hotel,

Check out the web; (https://www.bbc.com/news/world-africa-35332792) for more understanding, I shall send you more information and the bank details when I receive positive response from you to follow up.
Contact me through this my private e-mail
 lisamikerriding8@gmail.com

Thanks

Ms.Lisa Mikerriding
