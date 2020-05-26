Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3FC1C9E72
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 00:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgEGW0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 18:26:42 -0400
Received: from sonic307-16.consmr.mail.ne1.yahoo.com ([66.163.190.39]:35648
        "EHLO sonic307-16.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726579AbgEGW0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 18:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1588890400; bh=kkqUkFocv4LFpZvJoW0l2RwJGvQsSPyBJYcdmud8peA=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=EL9mw3i2z8BhjW7wEyQ7iuWPYX2gbkwJmVjhSg14FMnJHNG2UlEtn49qZu7tKQul0cW6wg1pOJA+5gmDbTv756zADwJB9hS0B3I2X17WrPInSz6mFQLFs1Cz57ZQY3c3ugXyaIJL8HZ9sOoyHVoItMEPXsM9uPUamTzlL8Hwxghlck2Tm1hY6T8oDpKNir7dapu+/fYxAWM4cVl4+678y1Psagy06uXOh85UAaQYbzCB1YrVx/OyAMs/ZPqgJFql4OaJ0qHf7jSrl+ImZuOcHYU2ew/MoYL4nyR07EY0rBsd2SXk+XREYkYI04+5k/BvkGDRRCLK4S0Rtt0Ngz5oKQ==
X-YMail-OSG: O0H.O9AVM1l8EnnjBXRtnMze3K8Oi8FzRnZw9SDacYi5yz5RC0QOLClfQfrS0G6
 2goUgIhSnruY_ijgPOtfSY88og55c40E3CyNWKDIqXynDfmX_bRm6U2aII4QzRr_8wEvPplHSvlZ
 nwjwJqIWXHEHSqFlaF5pBXV1w8Z2ZJQZpb7XnYs.nhcfDI7bUiVh6IUbzog1JEPCYUf96u4jWUXk
 O51DXbOpu14Iotwsil.x3ld87bgzuq9r49bBsObfbdCy7BE6IL4l1RGtMsvCBwtbeqxY.u6m7IF.
 bizZeWtA4h7FeOhmKwpU1z.0SLq4ElmGy7c4Bb5uVQCK.xpcPBN0H8629nmqAXjMzuj3Q_oiK9jJ
 qgGIqfH7HHxsrKsuJUR4cjFq5M2v_R.WYxFv5XPZu1jBz9vKegaij9OzVfvfs8l9V8mpNmsC552S
 IwVk_4pTbLFuK7FzbquYbVqlLgrHKpUff4d4D9GYDqUgzJwcPyf7kHPaTS7YaYRWdFggsyOIJxEj
 7WYrcf5UQe2O2yEdZbNITrfjlXMk4Fs0Up9lw2PJAI03rO5R65atoy0idZJzYwgLjXpopOUDosgw
 fYeGUMghwZijrQG0wwP7EotfXM2EiyrqxfK7IuSQySf9EH5NDItbkD7i3siMRYEYSFLlfcyo0At3
 johKn65w8k2Ozh5mNNUxcZ5gkblNxjkC.JY6ye2CBWbz8xLDe_rw6tZRawP4IMpe_xn4uLQ5ZiKO
 YIeRHOP1TBlvrhFdypKa7DkhsC434zV5S64WglMwGB8DlbtOxYgOpG8hJFMV5C9FW9ZqhRdYXcoB
 AfwiTEU8bG9g5_cb4WYLthuZyf_h6TxibWiFur.bhGTDpDy3cehFS.xoe9uGpnKKDbS7WutWi0kn
 3lizVJ9MNBncz9NF5.DM7Y6GXpAO5KrDqb6_xfe69QDSZwoYnEg4sZZt39cEF0g7GLHEMbeTUd.2
 E6gXefFyafhtfIy_SP.i9leOOz.fx45uZ3l1DVLh9MuwoFGlqZqA7rq4KDnh.BUlG5F0CUSfjh6s
 JAxyYQyigdd7RQnCTfkICeW6WZnnDmwpup5KeFP.L1ggRyx0Uky_znbXfIfojmaJ2JONffPNMZ8B
 FkC4pV6OmiiT4Md5RpgdkeMrCmLfKrlV8D7XOSeCrUkSRMwBc0xdQWteWDq1xZLfHcQvQv8knpfW
 euO.kyWsCIpbRtTivu0zEG1.zrMLeDMgK4RqXQ5pIUVEQdJLUKupyfOScbqtew8YdVJFcSlc4tXi
 7YDEJgruJr1hYX3jxiH18Geq72o6Q3nMuG3Rl.xlxpxLzzat_gDbdKH3DMbGmm2RLU09H2tFQhi6
 Q4swznOn7VQk3TqpudedQpqpitXFwgwGKmqe9_4d8z2UAgclKTJyKQNUOJEloIP7XguyuwlhFJkR
 vhApDuegm6gL9A8KExZ4Wuqao
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Thu, 7 May 2020 22:26:40 +0000
Received: by smtp432.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 634f847cc9cd4bcd27313d4b42edc628;
          Thu, 07 May 2020 22:26:35 +0000 (UTC)
Subject: Re: [PATCH 1/1] Smack:- Remove redundant inode_smack cache since now
 new cache is being used for inode_smack structure allocations
To:     Vishal Goel <vishal.goel@samsung.com>,
        linux-security-modulemodule@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CGME20200427043419epcas5p39e2a73db2dcc912df2624ee03bec1f58@epcas5p3.samsung.com>
 <1587960753-6006-1-git-send-email-vishal.goel@samsung.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 mQINBFzV9HABEAC/mmv3jeJyF7lR7QhILYg1+PeBLIMZv7KCzBSc/4ZZipoWdmr77Lel/RxQ
 1PrNx0UaM5r6Hj9lJmJ9eg4s/TUBSP67mTx+tsZ1RhG78/WFf9aBe8MSXxY5cu7IUwo0J/CG
 vdSqACKyYPV5eoTJmnMxalu8/oVUHyPnKF3eMGgE0mKOFBUMsb2pLS/enE4QyxhcZ26jeeS6
 3BaqDl1aTXGowM5BHyn7s9LEU38x/y2ffdqBjd3au2YOlvZ+XUkzoclSVfSR29bomZVVyhMB
 h1jTmX4Ac9QjpwsxihT8KNGvOM5CeCjQyWcW/g8LfWTzOVF9lzbx6IfEZDDoDem4+ZiPsAXC
 SWKBKil3npdbgb8MARPes2DpuhVm8yfkJEQQmuLYv8GPiJbwHQVLZGQAPBZSAc7IidD2zbf9
 XAw1/SJGe1poxOMfuSBsfKxv9ba2i8hUR+PH7gWwkMQaQ97B1yXYxVEkpG8Y4MfE5Vd3bjJU
 kvQ/tOBUCw5zwyIRC9+7zr1zYi/3hk+OG8OryZ5kpILBNCo+aePeAJ44znrySarUqS69tuXd
 a3lMPHUJJpUpIwSKQ5UuYYkWlWwENEWSefpakFAIwY4YIBkzoJ/t+XJHE1HTaJnRk6SWpeDf
 CreF3+LouP4njyeLEjVIMzaEpwROsw++BX5i5vTXJB+4UApTAQARAQABtChDYXNleSBTY2hh
 dWZsZXIgPGNhc2V5QHNjaGF1Zmxlci1jYS5jb20+iQJUBBMBCAA+FiEEC+9tH1YyUwIQzUIe
 OKUVfIxDyBEFAlzV9HACGwMFCRLMAwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQOKUV
 fIxDyBG6ag/6AiRl8yof47YOEVHlrmewbpnlBTaYNfJ5cZflNRKRX6t4bp1B2YV1whlDTpiL
 vNOwFkh+ZE0eI5M4x8Gw2Oiok+4Q5liA9PHTozQYF+Ia+qdL5EehfbLGoEBqklpGvG3h8JsO
 7SvONJuFDgvab/U/UriDYycJwzwKZuhVtK9EMpnTtUDyP3DY+Q8h7MWsniNBLVXnh4yBIEJg
 SSgDn3COpZoFTPGKE+rIzioo/GJe8CTa2g+ZggJiY/myWTS3quG0FMvwvNYvZ4I2g6uxSl7n
 bZVqAZgqwoTAv1HSXIAn9muwZUJL03qo25PFi2gQmX15BgJKQcV5RL0GHFHRThDS3IyadOgK
 P2j78P8SddTN73EmsG5OoyzwZAxXfck9A512BfVESqapHurRu2qvMoUkQaW/2yCeRQwGTsFj
 /rr0lnOBkyC6wCmPSKXe3dT2mnD5KnCkjn7KxLqexKt4itGjJz4/ynD/qh+gL7IPbifrQtVH
 JI7cr0fI6Tl8V6efurk5RjtELsAlSR6fKV7hClfeDEgLpigHXGyVOsynXLr59uE+g/+InVic
 jKueTq7LzFd0BiduXGO5HbGyRKw4MG5DNQvC//85EWmFUnDlD3WHz7Hicg95D+2IjD2ZVXJy
 x3LTfKWdC8bU8am1fi+d6tVEFAe/KbUfe+stXkgmfB7pxqW5Ag0EXNX0cAEQAPIEYtPebJzT
 wHpKLu1/j4jQcke06Kmu5RNuj1pEje7kX5IKzQSs+CPH0NbSNGvrA4dNGcuDUTNHgb5Be9hF
 zVqRCEvF2j7BFbrGe9jqMBWHuWheQM8RRoa2UMwQ704mRvKr4sNPh01nKT52ASbWpBPYG3/t
 WbYaqfgtRmCxBnqdOx5mBJIBh9Q38i63DjQgdNcsTx2qS7HFuFyNef5LCf3jogcbmZGxG/b7
 yF4OwmGsVc8ufvlKo5A9Wm+tnRjLr/9Mn9vl5Xa/tQDoPxz26+aWz7j1in7UFzAarcvqzsdM
 Em6S7uT+qy5jcqyuipuenDKYF/yNOVSNnsiFyQTFqCPCpFihOnuaWqfmdeUOQHCSo8fD4aRF
 emsuxqcsq0Jp2ODq73DOTsdFxX2ESXYoFt3Oy7QmIxeEgiHBzdKU2bruIB5OVaZ4zWF+jusM
 Uh+jh+44w9DZkDNjxRAA5CxPlmBIn1OOYt1tsphrHg1cH1fDLK/pDjsJZkiH8EIjhckOtGSb
 aoUUMMJ85nVhN1EbU/A3DkWCVFEA//Vu1+BckbSbJKE7Hl6WdW19BXOZ7v3jo1q6lWwcFYth
 esJfk3ZPPJXuBokrFH8kqnEQ9W2QgrjDX3et2WwZFLOoOCItWxT0/1QO4ikcef/E7HXQf/ij
 Dxf9HG2o5hOlMIAkJq/uLNMvABEBAAGJAjwEGAEIACYWIQQL720fVjJTAhDNQh44pRV8jEPI
 EQUCXNX0cAIbDAUJEswDAAAKCRA4pRV8jEPIEWkzEACKFUnpp+wIVHpckMfBqN8BE5dUbWJc
 GyQ7wXWajLtlPdw1nNw0Wrv+ob2RCT7qQlUo6GRLcvj9Fn5tR4hBvR6D3m8aR0AGHbcC62cq
 I7LjaSDP5j/em4oVL2SMgNTrXgE2w33JMGjAx9oBzkxmKUqprhJomPwmfDHMJ0t7y39Da724
 oLPTkQDpJL1kuraM9TC5NyLe1+MyIxqM/8NujoJbWeQUgGjn9uxQAil7o/xSCjrWCP3kZDID
 vd5ZaHpdl8e1mTExQoKr4EWgaMjmD/a3hZ/j3KfTVNpM2cLfD/QwTMaC2fkK8ExMsz+rUl1H
 icmcmpptCwOSgwSpPY1Zfio6HvEJp7gmDwMgozMfwQuT9oxyFTxn1X3rn1IoYQF3P8gsziY5
 qtTxy2RrgqQFm/hr8gM78RhP54UPltIE96VywviFzDZehMvuwzW//fxysIoK97Y/KBZZOQs+
 /T+Bw80Pwk/dqQ8UmIt2ffHEgwCTbkSm711BejapWCfklxkMZDp16mkxSt2qZovboVjXnfuq
 wQ1QL4o4t1hviM7LyoflsCLnQFJh6RSBhBpKQinMJl/z0A6NYDkQi6vEGMDBWX/M2vk9Jvwa
 v0cEBfY3Z5oFgkh7BUORsu1V+Hn0fR/Lqq/Pyq+nTR26WzGDkolLsDr3IH0TiAVH5ZuPxyz6
 abzjfg==
Message-ID: <7edd3a52-7f9a-11e6-2300-714b28d163ca@schaufler-ca.com>
Date:   Thu, 7 May 2020 15:26:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1587960753-6006-1-git-send-email-vishal.goel@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.15756 hermes Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/2020 9:12 PM, Vishal Goel wrote:
> Signed-off-by: Vishal Goel <vishal.goel@samsung.com>

I've taken this after adding a commit message.
Please include a commit message, even if you believe
the "subject line says it all" in the future.

> ---
>  security/smack/smack_lsm.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 2862fc3..d0f87d4 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -55,7 +55,6 @@
>  DEFINE_MUTEX(smack_ipv6_lock);
>  static LIST_HEAD(smk_ipv6_port_list);
>  #endif
> -static struct kmem_cache *smack_inode_cache;
>  struct kmem_cache *smack_rule_cache;
>  int smack_enabled;
>  
> @@ -4841,15 +4840,9 @@ static __init int smack_init(void)
>  	struct cred *cred = (struct cred *) current->cred;
>  	struct task_smack *tsp;
>  
> -	smack_inode_cache = KMEM_CACHE(inode_smack, 0);
> -	if (!smack_inode_cache)
> -		return -ENOMEM;
> -
>  	smack_rule_cache = KMEM_CACHE(smack_rule, 0);
> -	if (!smack_rule_cache) {
> -		kmem_cache_destroy(smack_inode_cache);
> +	if (!smack_rule_cache)
>  		return -ENOMEM;
> -	}
>  
>  	/*
>  	 * Set the security state for the initial task.
