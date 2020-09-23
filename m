Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B01275925
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 15:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgIWNvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 09:51:35 -0400
Received: from sonic301-8.consmr.mail.bf2.yahoo.com ([74.6.129.47]:42607 "EHLO
        sonic301-8.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726526AbgIWNve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 09:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1600869093; bh=VQV+To5S2gWVZyYzSF6aVVNoKJSf7fw7hH7Ff0SULss=; h=Date:From:Reply-To:Subject:References:From:Subject; b=IKkglCF/CoWriG0Yb8Q5VOiSDCLrTmEfx9T/7ro6Tbqj21HhW85dRwtc3/P2BlEQ1K2qcOdywj1FttrcAA/Jd/jr3nTstPz08UTyfEeqGWEVttEjQVurjPVKvDlTfMLEF0NToIyxK7hkGWZmJ3zKqUTetQ0spJgV2P5etqwv97MRQngQ2iBvXI3/U6z+uuntcyHIHEF598GlSFihMLv44DgdyUH3W4AYIwE3aZjkNd3R7ubPvaoQq/l5R+jKOzTInyssZSzPIAdFX+EfWRQIlsKwj3L4VUowM5iLTpHK9Q5dRNar0czwW3qkdDnTnCjQ3gvIzGGfxwiOUDhzY8JQjw==
X-YMail-OSG: qn2bFw4VM1lqSGodHAld7oqV9auwOWXkp2DevfFDa1hZZ0BJlyElpktnqwcuYnA
 8ymGUKl5z8sI0XhGZairiYPjP5z0UyyrjRYjnIlDWvPTgX3oo_cjdT4GhjgYEL3FXyulzYil6H6B
 5eEjoJmMWrnRxas1e3AyWJB0nb8LAGmQ7iGo7Q8nVrDrP6Bb_2rSvocfRbzoqxFOTNf3iwlePcIv
 C0m07QOtXLmSI7OGviLrFrOr1dHSDXHz.ze9O5oDoH78bVRDN9whDCQvz1Va1SzM0mbfHHMKi15h
 mQAlVVo.yCAO41D1jT5JInOUz4D1HDVJyzSg4y8jN4dSmknZWgx3JIjSNOmt4_J_1W91GAWj1wSq
 Gl.U9mfMsdjOfIyIcQonUFS8R_s_q_2A3TQ1.JtHYqTPhIjpRgtvvNtj8ic6QYfDpj8XcxBPM6hv
 408VjjZYm3k89paRNzEvnh5OyRj4YpO2kl01ybHVhAQAT_tdEv3ov8jtm6BUDZaMSvoC44W8.0pz
 52LBDFIGoqbJvYQz2tLF3DPUqYHjj1ybQZ5.HCz6OUfKfh7B3z_Ym.17z5Jw_pFRsfGkcDvLmdoL
 OOeV9Mxr5bRMVtNudq1zknL9zi7..IjE2U23oFppBr0zW7OYUoqrXRQmhLLnlBMFQK39SzWyCfoO
 4bHlhLpDc5J5tLKJnK3WaMqU9LmN32wW2VNBN.HwSOPTdfCxLjP182pF0bVjdWAy955SL0xNePlY
 U9sk1dNB.pKdkpwM.acHGnIK4ABaJXkVCHRMq845QMLLN2prL7HMhHOdQ2NyIoMGQqJaDM808QMq
 w2bjozXb4cEqn6kwP0wOZ.2gqYO5K6Xodp0LljItjviT9fMyfIeUjI9goMFw88ch6KkKNNKXCxlR
 U6BBUvK46vWMv2CtFF2uZWiPEbcHQaHohGaCRdRHIwvCxJrom7dgE6vcmSKWl65_83VzRhoyil8f
 nBrpZ4CcyrTpftd3D3_wn0IrDfzWaLRPYs_QKiBl3mVc5PqDCn4Pa6aPIv86Ug_UUpLJ7c_uOQsq
 YitB4jjtT0dDZpk8AkY3JaPiVWe5jmPwqWt1oLixvxRtQLyIOZsWCSzs4LFR3xQF7H2s6xEvUwJo
 2vDeFdiRfTZyuNrvV2YOWTg0iKVb.ZWR.NxjU7Luql9bR7OPBTGWELqt_0YzTiWJu9nQT5SytAyy
 NscwrkHJmdwLIPVuwThUHO7qZu85AYv8GIVOWzMlkWFV54EA480LPbbazLmE8jxLUvgQzZVelzcl
 VV4mWV0CI3AyRbLZOj6Jxhin1osQnoS5llDRAr9ilX_DNPE0vZyibQ5cPJgZgfMrVJmoMZI54ANQ
 W1f200FT0b3vJHy9JfrAZqQ7HqZ47FK0W5NwBWtQNn07EtMWeJJHWPXa7HiVL.et7YasszlrQZge
 f1B00KavmCbtbUDOnrJhZ1_sq5dTECfBOxzE2Oj7vuO.HbwQx
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Wed, 23 Sep 2020 13:51:33 +0000
Date:   Wed, 23 Sep 2020 13:51:33 +0000 (UTC)
From:   Wang Xiu Ying <gjgjtrrr@senfv.in>
Reply-To: wying353@yahoo.com
Message-ID: <71798255.5168324.1600869093110@mail.yahoo.com>
Subject: My business proposal
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <71798255.5168324.1600869093110.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16583 YMailNodin Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Good Day,
I am Wang Xiu Ying, the Director for Credit & Marketing Chong Hing Bank, Hong Kong, Chong Hing Bank Center, 24 Des Voeux Road Central, Hong Kong. I have a business proposal of USD$13,991,674 All confirmable documents to back up the claims will be made availableto you prior to your acceptance and as soon as I receive your return mail.
Best Regards,
Wang Xiu Ying
