Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397D31CDDE7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 16:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbgEKO5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 10:57:35 -0400
Received: from sonic308-56.consmr.mail.ne1.yahoo.com ([66.163.187.31]:34012
        "EHLO sonic308-56.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728367AbgEKO5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 10:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1589209053; bh=TYgdp/zNeW9P5rVjVpFopjba7a+Fm8hxyemx2bQVZd8=; h=Date:From:Reply-To:Subject:References:From:Subject; b=Ukza4caJV712bf4k5vkb6gI8N2c+8bj75P+J7SNAaETY1KLxFJbW1Ya34na9sZw3jjyDthszv+TYKTlIccyTxFg9g/f6SZy/cdR78qj5VNYHuyeqw063qWo9lEPrmJ/nepsqV7qu7R7U9u4dC/SnWkx+Iib2sxJcN0exnmnC14yQYipKaVNFXq4/nBGyPZsEyaQQNHYnBSxs/ildI8Tn/yzQIQn0YNW4JjYoOJdxX7nQ5duUIwKQbzCmb10O5z/MTvXn+5ZDH61sxNO4ABZvwNhSw4KGwx06LOfCUxEL/WYHurmI7B/YRHveipb7WGQxGPw3lWf9VyULKUnrU/TyUQ==
X-YMail-OSG: AmlN0ZcVM1kcjlYqovM0fuiRKCIW739NSqcNdjERkf2tTr8lNr.Wfen1A4gt.Ea
 x76J4FA5ygtXnC6KiJ3D9ELz8o31I5Al60aTVRVGzlG5K_JHExFYStfAHc86tnRfOHr0Z6gDLBeB
 5rSEyGbX2Sl6W4DKDi.vkrRiL3ggs4g1hqjN0fnHKlGWvURHuKYKS5_FaFJ0YFofIrT0twb6b7fW
 o80u85OsK6k_IFOk54yycw8akfn6wEG.wSuvmozuqzReKRlkHFYW1dBwg_kK6SUWpDjGpA7ZJ80q
 S6_V_TdkrSy500ilQzkbRquczw_Ha0zbp5VJvNWv6PzdOLhIFe1hSPdY1kNWUnkrZwNEvTTv0ks8
 IMJH5sFe9iaMo3in9NjVwfmOWapdExHepVWGvMcQknJiIMVM8cNDWkrinv5SKW.F18liagbUZxw8
 NtZkcE9Hdou6nTHk8_XOamBJObc2SzPTbw.OJZL0haCGDwcL_DqRYlBkFn654H8G0rRX42nSY9tF
 dpsCoP.RDlXLJYLrk1wu7vKeUZmXvCQqsrNvsrfQegLiopYLAwxEf.Wlvt3CdFcEqfg0LZDNiPaw
 JLc033CUmZ8s5hqvNyEtcCY7tVYH7E9pey5uIUzUjCs7JZYhYdi1AdsqNyHKy6PR_Jzh7kOGW8lf
 SXuqoDQbg8NUoZ.okWoRn2RVhxfF5oqK7t7bfIDUzFTg8tzXtGQvOPINRZXHZnIAKWWZofuc0dlt
 kVCuFLWm.o2bVe0cfTvDobOAkj7prKVGFEjwUjYtA7vOrlmoYtqT1nzMxXB.J0PJNnaliB.bF585
 sC.fY9EWSGr3fgL8f3EmWWZPthi6uoHAlgLP30LGJKQGQyREqNH9cpJsuWArPcGWaS.sT1WWxVHT
 _0Y6J6tIny95o5wp5._9tiP9r.PGlyJ3JmwtuwaMFDdU.nu40MoiB2Gc9ADeicQuLpdCFNulw4a8
 b5udzi_6Q5p966x0kzn.x1PRLxDgajbqt4HgSQWQLWqOK6fEs4OtsZ6A3Lx7ibBclOsPkMUY.vmG
 7yjp.N7I0RzM9mmRIJWDSZd_7s3puLRiRxroXRIb8Gh2l5o9ntFaG8.2GJx8ULGbbKNBrURjIX.q
 KkjYAtzCPg4Rw6Ki8JKtnvIlyOOWO94UIy624xM7OEF6VJh6D3.Jyc4HObt5GeUaZl2duSRUbW7s
 iIujW_DPmjkSjoof3IAiyp367Uewq7X6gm3_quPfr3wBmSWA6_R35d8U1941sVmnquz6gfS_91.o
 Qp9TBrJR2cwq2cUX1S.jCWG.YZPQoclpaWm_NyAlzaJkhzUKo8JbAMXh9H8.AJ3lA42kACdb3omf
 N1JwCykZZ4IHN8FDRGmHm47RgsIbg6JNb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Mon, 11 May 2020 14:57:33 +0000
Date:   Mon, 11 May 2020 14:57:32 +0000 (UTC)
From:   Mrs m compola <mmrsgrorvinte@gmail.com>
Reply-To: mcompola444@gmail.com
Message-ID: <527660704.1374381.1589209052087@mail.yahoo.com>
Subject: Dear Friend, My present internet connection is very slow in case
 you
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <527660704.1374381.1589209052087.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15902 YMailNodin Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
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
Mrs.mcompola444@gmail.com
