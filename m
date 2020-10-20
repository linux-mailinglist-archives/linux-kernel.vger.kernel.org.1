Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCEE8293F09
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 16:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408438AbgJTOwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 10:52:07 -0400
Received: from sonic303-2.consmr.mail.bf2.yahoo.com ([74.6.131.41]:40097 "EHLO
        sonic303-2.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728501AbgJTOwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 10:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1603205524; bh=Xr0ztq1I874QeBmeccNaswBgmnu3ktiw+E0tOg3mgcg=; h=Date:From:Reply-To:Subject:References:From:Subject; b=NO533hn/4bOfqOTO0Os618MQRo/zlDcgYOecriBLceWyVwWLywn2XIyd0kdMMqfoZHdr3ncToBqT4uWo45uOEVTEqHG/zyMGlW9HDTyqnJG0A/y+3JnxAT4QJoJRggRwzjhXW68rs8UndSykLpBUm9lzZL8Df2L9wtGH3h8LH9GfmlgGpQC7vdiwahDp2njPxVmXdnF+Sa2l6VZ4Hamdt2Rdj49JybuVsSI8WVXcj7tUOZupv8DQ4NgGrF8kOOgrVLPF3KlCyswtI8Ao6OLl6r6rRVZc3qjCvFjo/WYv/+efaVmjxddg1RXBF/41jZJWaGkGI8j6FInbIPHQgAFOWw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1603205524; bh=JoHkGPr6bKNC1Li9cE/5LZ07uNUquNCqwdleFiuK0Lk=; h=Date:From:Subject; b=lHAgcbSLMs5eJzSY4ihWRE5H/8ejaa9pjfIfOVFOgAap2Vj3isXDMN8NvkcBaxlalY91Cj1oHPxJyBz0K/X5ymYEz5Le8aAzvEtDNluYoiYuOEUCbXOVuRQuMPbqZFnoMsqr/hSENmhXaOP8ejb67vHtKjjbicXfHkzQvN/DcbDwcQpyAH62k5XNL/PE49NfGUgvkRTpj3p4YFH4iKg230t/ItMLfLiKaoHqlgooXqfdSK9d936x65MOubSfWovrVOH/YjBiQnqkHHXY7OzPzyNKJWKKdu0pZPrtAwtSHTws4sj8i0C8/cKBprN6CCii1WRaWSOfv8hfgpEKzmFBLw==
X-YMail-OSG: iaecyIwVM1nOxkC287uhmkZWOQY54CXuCa0Jz1wBhBAU_7_9HnSKH0XQ8izTcsV
 kfg3VtG4FqnSXzrPCWiSDv56uf08VuoN9mN8Xi.9zokW7raGwga_VUec14oPPuGX9yFej1o5gzM1
 .PxP3X1.8XYmq_IdrUytCAhMyJf8eWefXdSYV3AJNo0.wlBS50woKjao0aWS0LIMmsunX5djpFpc
 l160DRtuq5p.psAsd_nq6Xk4mkdWtBIYf47wKYFd6MvXUzs.InJNk_utKmkF3HjGoAdI4T9m16fn
 uCMxE_DBdoGWWBRI8YHVWKzDRVoZvIgHI9zaVCUQxiix8AlCIoBg.2DxYWBa27SzoVuSpA3QDHO1
 XuNtNoHLtqWlWE8NOfAagCxvBIrx.KOMNBcwx4qXPKP47_NVvWT5oi_.T3wO0fbtq6k2iEIerB0n
 pQ1IPxXMmkS25km.sG51Bp3UIQ1_CDPrWimoBvbkxjvh3NO98Y98OfCWONap090x2tQ2wIbPEnrJ
 dfiV4YLBtAfqYyVdWqiJtmTLhagJAOoTsNaYewswFNrlJ6ZC3bM0CBvpW5BQdiPMBhRJwfIi1CxZ
 8zmW.WpY_WfRpl1DX8VyAETJlLH.1jqSPgB0VL6OlYD0axynGM6uZu0mnTIIV_GjJv9apFAHUyTF
 MA1XUMTIITV.49uZp1RvThZC2yNIRUZ5NYNq0HuW.ERXHMlugSZdu9d4qcpBAjcLKJbWK5IFt8_K
 m5Cx4S.hsquLu3wYMwBrDCgSJ7xf20NI7us8gMdnsSSGlGlyGUx4lS.WC691gcek074WaYPt4NN.
 1cVZBs1O7fnx1F0TGgwa1sVp7v7UWvn4McVlw.mexdWwojsS9QUI0PCZ672IWZ7jO0weN2lh54W6
 u.LzYADvhmfSGjWv2n3Q8ZiDWLyxu_6.Yl55e62wl4z9n8bAgoewCq.oizm2w_Z5AToeHiSHPlx7
 X7GSPdIlTK6fnCVO90bsvkzr1I5B31oczD8ODXBxRi_bEEqtKkI4Fs6c2FgLgHtK0Pjfopx1jyVS
 ugvVIK.6DfejdLfqeeWmvj4xRK.GPOHvTBv6Ono4smU00d5KjoSkfrQYkx74o0061wWFAy5yEhE1
 og5XNx36wbf1F.5pUHK1R8IiMzhMcASYyBMAMmeehSuZb63n4XFmADrUkyPbyycKZyzaZKjhEd6h
 LithiF_KfpisLw46hzfXoFh4BUlUHG8DyiRoEMGl5NKKIN.QwFjyzVE4fQ7DSzS8tUlTLCaaOPWj
 WkIjZG1pLFI72pdFuoRutmSJe.CzSbHdsJBk4Z6VsV0DAiZO3AZVpRw4Non6H9otwUsuQApbKgq2
 pgSkjJrnUlnXtQf_7pvuAEjmgjcQjdV7KwmAoPGcpABXheR0HMUJvA6GRohSLtAkf88c6jSleubq
 b41nuc2B.v1fzz9fQXMlFtR4aG52qrQQ93IXn0ELY48OwvHf.CA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Tue, 20 Oct 2020 14:52:04 +0000
Date:   Tue, 20 Oct 2020 14:52:01 +0000 (UTC)
From:   susancoulibaly <susancoulibaly5@gmail.com>
Reply-To: susancoulibaly40@gmail.com
Message-ID: <2131885044.1060890.1603205521567@mail.yahoo.com>
Subject: Dearest
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <2131885044.1060890.1603205521567.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16868 YMailNodin Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dearest,
 
I know this mail will come to you as a surprise since we haven't known or come across each other before considering the fact that I sourced your email contact through the Internet in search of trusted person who can assist me.
 
I am Miss Susan Warlord Ibrahim Coulibaly 24 years old female from the Republic of Ivory Coast,West Africa ,am the Daughter of Late Chief Sgt.Warlord Ibrahim Coulibaly (a.k.a General IB ). My late father was a well known Ivory Coast militia leader . He died on Thursday 28 April 2011 following a fight with the Republican Forces of Ivory Coast(FRCI). I am constrained to contact you because of the maltreatment which I am receiving from my step mother.
 
She planned to take away all my late father's treasury and properties from me since the unexpected death of my beloved Father. Meanwhile I wanted to travel to Europe, but she hide away my international passport and other valuable documents. Luckily she did not discover where I kept my father's File which contained important documents. Now I am presently staying in the Mission in Burkina Faso.
 
I am seeking for long term relationship and investment assistance. My father of blessed memory deposited the sum of US$ 27.5 Million in one bank in Burkina Faso with my name as the next of kin. I had contacted the Bank to clear the deposit but the Branch Manager told me that being a refugee, my status according to the local law does not authorize me to carry out the operation. However, he advised me to provide a trustee who will stand on my behalf. I had wanted to inform my stepmother about this deposit but I am afraid that she will not offer me anything after the release of the money.
 
Therefore, I decide to seek for your help in transferring the money into your bank account while I will relocate to your country and settle down with you. As you indicated your interest to help me I will give you the account number and the contact of the bank where my late beloved father deposited the money with my name as the next of kin. It is my intention to compensate you with 40% of the total money for your assistance and the balance shall be my investment in any profitable venture which you will recommend to me as have no any idea about foreign investment. Please all communications should be through this email address for confidential purpose (susancoulibaly40@gmail.com)


 
Thanking you a lot in anticipation of your quick response. I will give you details in my next mail after receiving your acceptance mail to help me ,
 
Yours sincerely
Miss Susan Warlord Ibrahim Coulibaly
