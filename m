Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921F8202BF9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jun 2020 20:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730578AbgFUSJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jun 2020 14:09:36 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:39934 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730550AbgFUSJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 14:09:35 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id D2B2D467EF;
        Sun, 21 Jun 2020 18:09:28 +0000 (UTC)
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: Documentation/process
To:     Joe Perches <joe@perches.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Tony Fischetti <tony.fischetti@gmail.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>, Will Deacon <will@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jacob Huisman <jacobhuisman@kernelthusiast.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
References: <20200621133630.46435-1-grandmaster@al2klimov.de>
 <CANiq72kA==S-G481VHx2qrKkJmaVK7ZOuYmin4xVr3XKB8x8ug@mail.gmail.com>
 <b7ba0047-8993-d3bf-327c-1fb70bc0282c@al2klimov.de>
 <2c60a30eb1fd3616fccd496e76d3d1cc54afc732.camel@perches.com>
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
Message-ID: <61b1a32f-e49b-6667-6fe3-d4348b7cf38c@al2klimov.de>
Date:   Sun, 21 Jun 2020 20:09:27 +0200
MIME-Version: 1.0
In-Reply-To: <2c60a30eb1fd3616fccd496e76d3d1cc54afc732.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spamd-Bar: /
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 21.06.20 um 19:42 schrieb Joe Perches:
> On Sun, 2020-06-21 at 16:30 +0200, Alexander A. Klimov wrote:
>> Am 21.06.20 um 15:46 schrieb Miguel Ojeda:
>>> On Sun, Jun 21, 2020 at 3:37 PM Alexander A. Klimov
>>> <grandmaster@al2klimov.de> wrote:
> []
>>>>               Replace HTTP with HTTPS.
> []
>> W/o a
>> such central "rule on how to HTTPSify links"
> 
> Maybe:
> ---
>   scripts/checkpatch.pl | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 524df88f9364..4e49187a6137 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3115,6 +3115,12 @@ sub process {
>   			}
>   		}
>   
> +# check for URLs using old http:// links, suggest https:
> +		if ($rawline =~ m{^\+.*\bhttp://}) {
> +			WARN("HTTP_URL",
> +			     "Prefer URLs using https: over http:\n" . $herecurr);
> +		}
> +
Good idea!

>   # discourage the use of boolean for type definition attributes of Kconfig options
>   		if ($realfile =~ /Kconfig/ &&
>   		    $line =~ /^\+\s*\bboolean\b/) {
> 
> 
