Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537892DB453
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 20:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731946AbgLOTLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 14:11:48 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:55825 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731829AbgLOTLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 14:11:33 -0500
Received: from [192.168.1.155] ([95.118.67.37]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M4aEC-1kquNN08vO-001mM2; Tue, 15 Dec 2020 20:08:31 +0100
Subject: Re: [PATCH] arch: x86: make video init optional (expert)
To:     Randy Dunlap <rdunlap@infradead.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com
References: <20201207212033.2736-1-info@metux.net>
 <0d4f7c6a-0f66-9031-556b-1e5d51e52edb@infradead.org>
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
Message-ID: <3d9c5d04-653c-4298-481c-19b5204d5204@metux.net>
Date:   Tue, 15 Dec 2020 20:08:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <0d4f7c6a-0f66-9031-556b-1e5d51e52edb@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:tTSwN6xyYlSJZIjOu/nOKKCHto0A2TnQZhm3XdllUrsQi6Tqlsh
 jCO8Ftsm5xN0fzJ7wvyqR+JFKHzYI/ZmDE8Fn8+f3vMSTOjuW82cD1KlGdgOvJ4InTzRwbk
 hhGTEeziQWl2YUqYd2HgHJpxWafXE9v6xUm/wecM50a/3CgEr39XlwDbUoZ2zmSweRjpdYK
 m8C2wEniZIOHLAsZ2KUlg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tlqtDdwrA5w=:vwLBJ45m5G3V55q56X6RsW
 ujk5HKqWTBHW7CBMwePxvbB8cyIMdgQLz9YsesYEcApDB5f//LLZsQY2qssHOwLPEDU0ChQI1
 buPR8HymgFDq4W/C8RBYc23nCwDlk2fmVCl4c0PVn9FUfGSG+8yyqTOefDtRuRCi20L8Fg67v
 VUAsKmZaujYUuyXrBrehoL7cw2shbEP1btlUm0eK7ZEBVW5dnORoQ0jzvE1amxst8+znLOOlk
 7wQGTY6Ojv0h7DHV0FQTORDxDf65hjCW9mHXhsAlwsulLIhGXLR4wVAnNBJnNsxgMDvJN+IMG
 ntpbkVbZ7dqCkfuGBjZmF6eTLg77a8tzcDdXz+ipysUdQHGfOkVZp6hruIWWWk+q4JZSfjTU0
 tQvbCxdSPzzhY5br22aPzIDGBrOMg1WU8OUAcZOwOtw1KXJAVPNvONs7nwnq0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.12.20 22:57, Randy Dunlap wrote:

<snip>

thanks, fixed it.
sending a v2 in a few minutes.


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
