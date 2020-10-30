Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E572A0C46
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 18:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgJ3RON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 13:14:13 -0400
Received: from mout.gmx.net ([212.227.15.15]:45309 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgJ3ROL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 13:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604077994;
        bh=u58h8gCb73+OjNGvUEWx/4VmTh/CXrnB7kE+Wug7dbc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=DHsyD1KNPeMumollSpwyfb14WxdT6rF/Wo73RC0vgST4YfmInJg1uldLL2xI12CTR
         luq8ar8cNHYsSI7lFkoLN6PIXM/yjvPQMU8JTNQM2SeEQe6BU0pAnzcgZALgMxk/bX
         AgcTRYnCrTc+xes8+IVuXRL8gn+khBZfI/VR2P9E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.58] ([92.116.183.159]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwwZd-1kBFeT16BX-00yNGl; Fri, 30
 Oct 2020 18:13:14 +0100
Subject: Re: [PATCH v2 07/15] parisc: use legacy_timer_tick
To:     Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Finn Thain <fthain@telegraphics.com.au>,
        Philip Blundell <philb@gnu.org>,
        Joshua Thompson <funaho@jurai.org>,
        Sam Creasey <sammy@sammy.net>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-ia64@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20201030151758.1241164-1-arnd@kernel.org>
 <20201030151758.1241164-8-arnd@kernel.org>
From:   Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 mQINBF3Ia3MBEAD3nmWzMgQByYAWnb9cNqspnkb2GLVKzhoH2QD4eRpyDLA/3smlClbeKkWT
 HLnjgkbPFDmcmCz5V0Wv1mKYRClAHPCIBIJgyICqqUZo2qGmKstUx3pFAiztlXBANpRECgwJ
 r+8w6mkccOM9GhoPU0vMaD/UVJcJQzvrxVHO8EHS36aUkjKd6cOpdVbCt3qx8cEhCmaFEO6u
 CL+k5AZQoABbFQEBocZE1/lSYzaHkcHrjn4cQjc3CffXnUVYwlo8EYOtAHgMDC39s9a7S90L
 69l6G73lYBD/Br5lnDPlG6dKfGFZZpQ1h8/x+Qz366Ojfq9MuuRJg7ZQpe6foiOtqwKym/zV
 dVvSdOOc5sHSpfwu5+BVAAyBd6hw4NddlAQUjHSRs3zJ9OfrEx2d3mIfXZ7+pMhZ7qX0Axlq
 Lq+B5cfLpzkPAgKn11tfXFxP+hcPHIts0bnDz4EEp+HraW+oRCH2m57Y9zhcJTOJaLw4YpTY
 GRUlF076vZ2Hz/xMEvIJddRGId7UXZgH9a32NDf+BUjWEZvFt1wFSW1r7zb7oGCwZMy2LI/G
 aHQv/N0NeFMd28z+deyxd0k1CGefHJuJcOJDVtcE1rGQ43aDhWSpXvXKDj42vFD2We6uIo9D
 1VNre2+uAxFzqqf026H6cH8hin9Vnx7p3uq3Dka/Y/qmRFnKVQARAQABtBxIZWxnZSBEZWxs
 ZXIgPGRlbGxlckBnbXguZGU+iQJRBBMBCAA7AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheA
 FiEERUSCKCzZENvvPSX4Pl89BKeiRgMFAl3J1zsCGQEACgkQPl89BKeiRgNK7xAAg6kJTPje
 uBm9PJTUxXaoaLJFXbYdSPfXhqX/BI9Xi2VzhwC2nSmizdFbeobQBTtRIz5LPhjk95t11q0s
 uP5htzNISPpwxiYZGKrNnXfcPlziI2bUtlz4ke34cLK6MIl1kbS0/kJBxhiXyvyTWk2JmkMi
 REjR84lCMAoJd1OM9XGFOg94BT5aLlEKFcld9qj7B4UFpma8RbRUpUWdo0omAEgrnhaKJwV8
 qt0ULaF/kyP5qbI8iA2PAvIjq73dA4LNKdMFPG7Rw8yITQ1Vi0DlDgDT2RLvKxEQC0o3C6O4
 iQq7qamsThLK0JSDRdLDnq6Phv+Yahd7sDMYuk3gIdoyczRkXzncWAYq7XTWl7nZYBVXG1D8
 gkdclsnHzEKpTQIzn/rGyZshsjL4pxVUIpw/vdfx8oNRLKj7iduf11g2kFP71e9v2PP94ik3
 Xi9oszP+fP770J0B8QM8w745BrcQm41SsILjArK+5mMHrYhM4ZFN7aipK3UXDNs3vjN+t0zi
 qErzlrxXtsX4J6nqjs/mF9frVkpv7OTAzj7pjFHv0Bu8pRm4AyW6Y5/H6jOup6nkJdP/AFDu
 5ImdlA0jhr3iLk9s9WnjBUHyMYu+HD7qR3yhX6uWxg2oB2FWVMRLXbPEt2hRGq09rVQS7DBy
 dbZgPwou7pD8MTfQhGmDJFKm2ju5Ag0EXchrcwEQAOsDQjdtPeaRt8EP2pc8tG+g9eiiX9Sh
 rX87SLSeKF6uHpEJ3VbhafIU6A7hy7RcIJnQz0hEUdXjH774B8YD3JKnAtfAyuIU2/rOGa/v
 UN4BY6U6TVIOv9piVQByBthGQh4YHhePSKtPzK9Pv/6rd8H3IWnJK/dXiUDQllkedrENXrZp
 eLUjhyp94ooo9XqRl44YqlsrSUh+BzW7wqwfmu26UjmAzIZYVCPCq5IjD96QrhLf6naY6En3
 ++tqCAWPkqKvWfRdXPOz4GK08uhcBp3jZHTVkcbo5qahVpv8Y8mzOvSIAxnIjb+cklVxjyY9
 dVlrhfKiK5L+zA2fWUreVBqLs1SjfHm5OGuQ2qqzVcMYJGH/uisJn22VXB1c48yYyGv2HUN5
 lC1JHQUV9734I5cczA2Gfo27nTHy3zANj4hy+s/q1adzvn7hMokU7OehwKrNXafFfwWVK3OG
 1dSjWtgIv5KJi1XZk5TV6JlPZSqj4D8pUwIx3KSp0cD7xTEZATRfc47Yc+cyKcXG034tNEAc
 xZNTR1kMi9njdxc1wzM9T6pspTtA0vuD3ee94Dg+nDrH1As24uwfFLguiILPzpl0kLaPYYgB
 wumlL2nGcB6RVRRFMiAS5uOTEk+sJ/tRiQwO3K8vmaECaNJRfJC7weH+jww1Dzo0f1TP6rUa
 fTBRABEBAAGJAjYEGAEIACAWIQRFRIIoLNkQ2+89Jfg+Xz0Ep6JGAwUCXchrcwIbDAAKCRA+
 Xz0Ep6JGAxtdEAC54NQMBwjUNqBNCMsh6WrwQwbg9tkJw718QHPw43gKFSxFIYzdBzD/YMPH
 l+2fFiefvmI4uNDjlyCITGSM+T6b8cA7YAKvZhzJyJSS7pRzsIKGjhk7zADL1+PJei9p9idy
 RbmFKo0dAL+ac0t/EZULHGPuIiavWLgwYLVoUEBwz86ZtEtVmDmEsj8ryWw75ZIarNDhV74s
 BdM2ffUJk3+vWe25BPcJiaZkTuFt+xt2CdbvpZv3IPrEkp9GAKof2hHdFCRKMtgxBo8Kao6p
 Ws/Vv68FusAi94ySuZT3fp1xGWWf5+1jX4ylC//w0Rj85QihTpA2MylORUNFvH0MRJx4mlFk
 XN6G+5jIIJhG46LUucQ28+VyEDNcGL3tarnkw8ngEhAbnvMJ2RTx8vGh7PssKaGzAUmNNZiG
 MB4mPKqvDZ02j1wp7vthQcOEg08z1+XHXb8ZZKST7yTVa5P89JymGE8CBGdQaAXnqYK3/yWf
 FwRDcGV6nxanxZGKEkSHHOm8jHwvQWvPP73pvuPBEPtKGLzbgd7OOcGZWtq2hNC6cRtsRdDx
 4TAGMCz4j238m+2mdbdhRh3iBnWT5yPFfnv/2IjFAk+sdix1Mrr+LIDF++kiekeq0yUpDdc4
 ExBy2xf6dd+tuFFBp3/VDN4U0UfG4QJ2fg19zE5Z8dS4jGIbLrgzBF3IbakWCSsGAQQB2kcP
 AQEHQNdEF2C6q5MwiI+3akqcRJWo5mN24V3vb3guRJHo8xbFiQKtBBgBCAAgFiEERUSCKCzZ
 ENvvPSX4Pl89BKeiRgMFAl3IbakCGwIAgQkQPl89BKeiRgN2IAQZFggAHRYhBLzpEj4a0p8H
 wEm73vcStRCiOg9fBQJdyG2pAAoJEPcStRCiOg9fto8A/3cti96iIyCLswnSntdzdYl72SjJ
 HnsUYypLPeKEXwCqAQDB69QCjXHPmQ/340v6jONRMH6eLuGOdIBx8D+oBp8+BGLiD/9qu5H/
 eGe0rrmE5lLFRlnm5QqKKi4gKt2WHMEdGi7fXggOTZbuKJA9+DzPxcf9ShuQMJRQDkgzv/VD
 V1fvOdaIMlM1EjMxIS2fyyI+9KZD7WwFYK3VIOsC7PtjOLYHSr7o7vDHNqTle7JYGEPlxuE6
 hjMU7Ew2Ni4SBio8PILVXE+dL/BELp5JzOcMPnOnVsQtNbllIYvXRyX0qkTD6XM2Jbh+xI9P
 xajC+ojJ/cqPYBEALVfgdh6MbA8rx3EOCYj/n8cZ/xfo+wR/zSQ+m9wIhjxI4XfbNz8oGECm
 xeg1uqcyxfHx+N/pdg5Rvw9g+rtlfmTCj8JhNksNr0NcsNXTkaOy++4Wb9lKDAUcRma7TgMk
 Yq21O5RINec5Jo3xeEUfApVwbueBWCtq4bljeXG93iOWMk4cYqsRVsWsDxsplHQfh5xHk2Zf
 GAUYbm/rX36cdDBbaX2+rgvcHDTx9fOXozugEqFQv9oNg3UnXDWyEeiDLTC/0Gei/Jd/YL1p
 XzCscCr+pggvqX7kI33AQsxo1DT19sNYLU5dJ5Qxz1+zdNkB9kK9CcTVFXMYehKueBkk5MaU
 ou0ZH9LCDjtnOKxPuUWstxTXWzsinSpLDIpkP//4fN6asmPo2cSXMXE0iA5WsWAXcK8uZ4jD
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <2e2d7b65-0aa8-55aa-d395-52cfb048adef@gmx.de>
Date:   Fri, 30 Oct 2020 18:13:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201030151758.1241164-8-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JxkfastojmLulDZL44lcaQ3m9vou/OwY8ufVXHztjdcGmjTQI5M
 CE0bW3jzNETdRucvEAviHOadNLN77lRXHuLjqeX5JesjRmk5FsMNoH4DwGxYWXqj9pwdYAY
 V0bi4/0Jf2tuR2V/qvvmkBqrqaB+LTn93TN+OaRxSVa52VdZAUFOf0CYAJhe0qNuJd8anW9
 noc74UbvKmuUT0V5yU1Hg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VjSJQ8bKp4c=:Cv7FqAtRaR1qFGr6+FWAjC
 UI7TzXJOxxkLJjIIVBc/fU923p1cqcjkH8VhHjt2+K71bdo8b9r3nuf4/T7ftucJx36j3ZhYy
 rxwW4Zrx+LRIAhqfZe8XOij8Sj4a/KeC1hPBi1mV8OEXrsZ/IabZ/HvlS+ze1XljOZxveEz4t
 svJeXixkpD9COjMc6rpv5ClQTMyG0S6iuvIT7EHeVg2WJ6/qV39MptdKbomDUY132XU97NfM2
 x6NgW9SP427oA9X89JF7lxuYczEltQIs/xhfGhArOGEcOsdJ8JjSP6JsUEKXYpDXvSsre+HX7
 MnGfQjOb68xfoRATrP4A+c5ivkMC3rkOd4p46CjjhUSUmlOQwgW+PoJMqaYDHKHpe/Dm7e6+5
 sRFCpCzGBK24RwvriDSfULr3RUfVrXeEBVceXczKmnmWPO5jbPJMRMTEIIn3yJgTLZIJaxT5/
 LKCN5wEwv1GpkFgqdfMv5Ss0RD7bG48QkEnKALEY4gQIPGqHOuJuIV5TVvUSh/2yJUAR4EWM7
 Me0G0oFEVGrVH7+4Onm3x0FhoaoZTY8fDDJklf0wqSRSY1NreZChC6/LJw43b/G61Twjky4QM
 LvSAZ3xnW/ZUIaS+K+SwRqgWBvpu4y2Xffntjaw5+ZpYXVN/60LUjvBW5BQercNaCP5DYsbLA
 rLGJIKtDoTacvxHtCi+MlTkBzMPBeCnZcJHkgL+tDLk8rZ8RygmX4qb9vQikUUQa61Hnxm8JZ
 +mlVT+AMg4HG6mUUlzElTkqv1rfBD+gtgmhDGUWDeBgYqAtsfxfTgWGF1iZ4chMfkDX03XKzR
 O9ncbND+NDuegXDBz/uxLLmsFlKJuPyIq7dIdIwZJRkBx48tSxFFYM72EUki0y4iwtgU1H6AI
 dDMDWXCjlkHF4JWufpnQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/20 4:17 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> parisc has selected CONFIG_GENERIC_CLOCKEVENTS since commit 43b1f6abd590
> ("parisc: Switch to generic sched_clock implementation"), but does not
> appear to actually be using it, and instead calls the low-level
> timekeeping functions directly.

Arnd, thank you for this patch!
It reminded me that I really missed to fully implement the clockevents on =
parisc!

Your other patch ("RFC: m68k: mac: convert to generic clockevent")
was a big help too, as it showed how it might work on parisc as well.

Here is now a current version of the clockevents-enabling-patch for parisc=
:
https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/co=
mmit/?h=3Dfor-next&id=3D3b7ab4a74a2d1972dbeb33285d85f1500b2ff96a

> Remove the GENERIC_CLOCKEVENTS select again, and instead convert to
> the newly added legacy_timer_tick() helper.

My patch still needs more testing, but if it turns to work
out right, would you mind to drop your patch for parisc?

Helge


> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  Documentation/features/time/clockevents/arch-support.txt | 2 +-
>  arch/parisc/Kconfig                                      | 2 +-
>  arch/parisc/kernel/time.c                                | 9 +++------
>  3 files changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/features/time/clockevents/arch-support.txt b/=
Documentation/features/time/clockevents/arch-support.txt
> index 8287b6aa522e..61a5c9d68c15 100644
> --- a/Documentation/features/time/clockevents/arch-support.txt
> +++ b/Documentation/features/time/clockevents/arch-support.txt
> @@ -21,7 +21,7 @@
>      |       nds32: |  ok  |
>      |       nios2: |  ok  |
>      |    openrisc: |  ok  |
> -    |      parisc: |  ok  |
> +    |      parisc: | TODO |
>      |     powerpc: |  ok  |
>      |       riscv: |  ok  |
>      |        s390: |  ok  |
> diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
> index b234e8154cbd..78b17621ee4a 100644
> --- a/arch/parisc/Kconfig
> +++ b/arch/parisc/Kconfig
> @@ -52,7 +52,7 @@ config PARISC
>  	select HAVE_REGS_AND_STACK_ACCESS_API
>  	select GENERIC_SCHED_CLOCK
>  	select HAVE_UNSTABLE_SCHED_CLOCK if SMP
> -	select GENERIC_CLOCKEVENTS
> +	select LEGACY_TIMER_TICK
>  	select CPU_NO_EFFICIENT_FFS
>  	select NEED_DMA_MAP_STATE
>  	select NEED_SG_DMA_LENGTH
> diff --git a/arch/parisc/kernel/time.c b/arch/parisc/kernel/time.c
> index 13d94f0f94a0..08e4d480abe1 100644
> --- a/arch/parisc/kernel/time.c
> +++ b/arch/parisc/kernel/time.c
> @@ -70,8 +70,6 @@ irqreturn_t __irq_entry timer_interrupt(int irq, void =
*dev_id)
>  	/* gcc can optimize for "read-only" case with a local clocktick */
>  	unsigned long cpt =3D clocktick;
>
> -	profile_tick(CPU_PROFILING);
> -
>  	/* Initialize next_tick to the old expected tick time. */
>  	next_tick =3D cpuinfo->it_value;
>
> @@ -86,10 +84,9 @@ irqreturn_t __irq_entry timer_interrupt(int irq, void=
 *dev_id)
>  	cpuinfo->it_value =3D next_tick;
>
>  	/* Go do system house keeping. */
> -	if (cpu =3D=3D 0)
> -		xtime_update(ticks_elapsed);
> -
> -	update_process_times(user_mode(get_irq_regs()));
> +	if (cpu !=3D 0)
> +		ticks_elapsed =3D 0;
> +	legacy_timer_tick(ticks_elapsed);
>
>  	/* Skip clockticks on purpose if we know we would miss those.
>  	 * The new CR16 must be "later" than current CR16 otherwise
>

