Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C042B6C5D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730171AbgKQRwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:52:02 -0500
Received: from sonic305-27.consmr.mail.ne1.yahoo.com ([66.163.185.153]:35762
        "EHLO sonic305-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726697AbgKQRwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:52:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1605635520; bh=pI/WchJRmyl847uwCAvChdR2r36oS7nZko9ZeCBmai0=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=QscYiw/h137vBtgvE7sKRGFIz/Jt9PKxb+oYtRZQ7c2fGOq4SIWijh/PZjPxfb9L+mKQGWZ0IkNuI/UF6TjDevbKeqO57hV2HrvCqiVTzhENXxRtx+YaQwgWyYfNc3Ws4fIWNSmv1psdTtoQ3g5bj4KEF2o86nvLpA3p+iLk4NSGzU0PWZPwyPTFi0LGlzWdQzQigfSvN/vyhwO6twE1fa0tB9UYLU86kZXqVeaaGPPHGIuGwCSsX2sPWaR2O5dgL0wfcWUu2k8fQp9j8mcuL709OdUvhiKXbOE5iiSk7hua5a53JKlhhtYdoqurJoEPzMDzzBidiH+hbY1FZtbYPQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1605635520; bh=7lBbhgRNL3N7my4dxD/pW/k6S6jQ025c67SnmVCcEuq=; h=Subject:To:From:Date:From:Subject; b=rwipkdT2IImsrjCy6ILt/RY/MdKxTnozlzGzI1l0TnTEhtrkcvwqcMAc2M1ikBMtJtFFDXrfgoE4THbDRhwbUP47UQ1VRM/q9oAwC6zh/SrIgV6617LQxvovxud7oC/UdZHIlhnoA9a38CA5xb068d7Rp0iVcIz6hpJeusO2A0ssm+cGL39Gam9mxkXJSO8xlX/BzjhffGWBSx8Hb9IYF3cGlH814V9e3RERNaQedyDPMiVv+avOLyo/BKGuaH2vBLIYXOcziCbqCOVzqi1EdvoIBMlw+PQHHnpT9Q94tX4JYOjS3v1odRJnKVubVxyFnxA8buUWKxMb6KRAnBPEfw==
X-YMail-OSG: J4DU.RoVM1krrAKgC4g8vnktCc_zC_6XF5l37YYOzZ37vIzc0yhylenyuH3.PTp
 maCirYX.CnKFEeDOtDsKJO8.HaaM7LX6CfgL1j5U3Xu4sgYrSNIBsYQbGPA6gX1byaI3v.X7q1jK
 dCFT.W0DsaLXC3RJpgB9Bm2.g96TyWmTiKApBeHqi7LzgOXtGKLbd_7Zxqm4ElnPvT2lhuvMnX5r
 6LcP0G2zFJ9UrjaRII4qG1ItaL0Qbcz_UQfUBLMrwRyYVoXvVdMl_qI9ZdVo9SEILDlBji191MVg
 1pD9PbIUs35OI46AncziFlGrtZmCz2vEkZls9E3OXDpfZaK7vGYomnP8zVCrDLAFBgcrXDuctyhM
 w8wbaxa9hRlvo3xBjlCY6rViBnAUuGEJnBtLr53FaZa_diW8p2PUwar0_hKdztsmiCEVqNEzVNfq
 CQciek.gfONr3_l0aMND8T_x4x1qQSv_y_GYT0H4jKWCjPXDzxGALI4PE0J3Ht9RUwgC8OhRZfyr
 D6tyvuDjT4AzJ370dxRBFViBR9wufeJWx6imJYPfTx50kjQQ9GgBbUBtBt4MXZJ_7li.4Fbl..f7
 S0sjdxk27P85Vd5hvhgXs45z3Nz1rgERaIxW.kzch2Jdh67h8gbcBavkY.1V8iQM1l.jGmmBHokA
 PZfaGyJPMK0gwiq3bL1rxFYtn0d63PzKzuvMDJvI06T1kPwqecNE5O9W73nwVrYVEnRURMMvOKRd
 NCV0nv2rkiUZ2mWgcuSpLKTH9MyxiYitOzCZTKj2x7q2f7VLydz8oBiXQY0gvI7gaphpUNR7EDpR
 5SHuIX1bTnk3LaRzeDugOmPxoMDpYlIzBAhfvErGXxRgoSrG3FEB6XT_yaPNHjovP_k5yIzEty5D
 _HAvWPDntca_Dr9f3Gdmd5R9vHY4wUUax6pfzhOl7l_mmO7_SmrundRtNvbtu10HJUyINSUC_x8S
 zwAFh78APL4tH0JMgtHeVQYB6YSd0lSAVb51nVDts.jcsOmSpvO4.4vr67_hTOhxpDonexIMHMhK
 I7cP4pvuc2hNPFRahhR1DNDI5Cdg14VsRLCCPRqxwAhTPq20mApwoCLw3PBySYSYVzNSJgCEDBEU
 SkvnFaMAXc1QxnOn17ONu.8aguv8i7Q0C3OXPhcNyqIMVkGDA81XAnp_Z2Cqu1DJRjTHDuBCE1Hw
 Oh3v67zGck69K4fuGZuA7J1SRe.Niaah_V7OUTwtlq43e5EGM5hig_l37._g3ET3SmMmegGgJyx6
 FDrhCr8VJ3TlG0uigPewkZC2ncPCv_2IiDaR74aWLPJZI0JjGdfLEZ6A2oIM3wKY_OMn.KRRq2gD
 HhwVHw2770_5acAfSoBn.Fh2IPPH98hJMgQDluLUugtm53UExjCt8MJW8SrYIKGBrtloacqx_8_8
 4gAl2NUDVoSc.UPtVHbWi8Cn6eFj3dkomLeuUisARBpL5uRmhML9SYD26puhhOdnVjQsDcs9aV1y
 mFmt7x.QzCnN.5W.NMv8W0mB0DhiYSiZ2nn68Mizw3du5_LtdLCJXNzNKeNXHlN06zSB7910M0B9
 ifNTdt9vsmc.mxmv3BBVH7yDGnK7q7hxmvDPllNSu_OtM6WWPXk1g1h6Ngf4yWqF8TB6tUrJL0w9
 AWGEzNDgErerXiK8ymhQNYTlgaai3J4M5dmld68ijoI1hXfhRjSz9tqKCgf.ZevnFFhLzG6vvYDQ
 fN7SdWgCNobTdiPx8gV7Xdq9k9THk8NwUu7ZRFXrbPE1cSQjtLTs6AOn1NzxtYRcvsPCeLRxKrGg
 AnBqufezhRJjg_fZBVfIwBkM3nD7dnd7yO9TV1da68sArS_W9GfzCA1RCNOYZ.Az_51M_KwFtT8m
 FEgG0I269Os28gFwUMeAFu9q2ErmK.e60Rc2qAVCStpGOVrOcOC0nvFqMT_0wdH7sdgNGseczrni
 at2PxV19JFo7TroYgT4mphblsp3P7qCpNYCFM1npYueE2_Kf9z_Z8aIa_k1SbX3lHE_vpIgdOxC_
 uZA8jFBVDkghuurJPYV7SKyFhhdKoWLGiTstcKg8ObmDxzHJLS3uJXjQmVRAo9SA..L5o7zrxBZU
 9Tv5UP70EkrOHSqh0E6XplA5NmQogwQkzqgB1YXR5V1iNONihrNJ.j7E4LPUwF2gvH9cuG1r8lxT
 IZJO06slVlt6Bgc_kxDEPzW3TDNUNGB4Jqo2JaV5Osnp1pc32YZxxVWRdDEi2TNk1OUZW_uUCEoK
 dMpjF8ijnzYf3wAdTV_pl0CqWRHQFcv3ximbdFO9iFIdsBzUimm233daZNhBkWrVmSzNo_v.Jrgr
 jwN7QhDlQOwpO0J2Jc8D6TTx3WV.PS2DgA.0JOCb.XsN6pwQOe75oDobcQwnjG0MjK0lExBlQ3Ob
 yYYpNF1Z2wA.dLGhj_aAF7ECp.1ouknnlUczKgTTobi58j78MYVBq_NUwjGu7jrLLxUS8Vd8g971
 8lPyl4k1z9JcOg4PScIk7MJyQU9a0GwSSfTVofng0KU86onVrVHtHClTlDRoXSj0EAWZ118I758V
 ZcBRhVFyAzKbtq918ctHh4UDJGYQ3NSt8DUfihO8U7JW.bgUdAboWkcDZXfxKLelw_5z8pkFL7cO
 D2_0a7WKEWYe3lI2dq.l5guOEcF5ppcwUjGAxuS2JzHOgjEFN0LCC7GXexxAy5oxlAq2klD7hqFb
 41QiP8O0eXwWLvga2FkZTs2rSa2fyRYPhdOxouFh18spZAD99sZK_D7.ubiYJD1fsrCfGlXUousY
 5d.uiqcq8E81yT8kw_QgRUharSx2X6Cof53c1St8Fe4LJxBp7.9hi8fQulEb_uddSLox7XFBtfa9
 a6Oy.GrecYW4LTeprppubb6SKuYl1IaeHxnc5TC.AL4fAZCA59Sqv4mDvVl3KT4DG9XZBbWijPnL
 1.NAyidpWKl17e4UQ9GMd6hvl7VcKYiUAlT5174mKAU4r1Wz_.d0cxdXlvaqf1ypbOBQ5aHgf6yA
 ZmG3hjZuJ6ikcihIl_8H9aQJMEiNpMJwXCfgW
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Tue, 17 Nov 2020 17:52:00 +0000
Received: by smtp403.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 86769df53fb1d1ddcd034f8c77b963b8;
          Tue, 17 Nov 2020 17:51:54 +0000 (UTC)
Subject: Re: [PATCH] fix namespaced fscaps when !CONFIG_SECURITY
To:     "Serge E. Hallyn" <serge@hallyn.com>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     James Morris <jmorris@namei.org>,
        =?UTF-8?Q?Herv=c3=a9_Guillemet?= <herve@guillemet.org>,
        "Andrew G. Morgan" <morgan@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20201117150856.GA12240@mail.hallyn.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <611aad55-90f4-ee49-6f95-7b2219eeecb2@schaufler-ca.com>
Date:   Tue, 17 Nov 2020 09:51:52 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201117150856.GA12240@mail.hallyn.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.16944 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.8)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/2020 7:08 AM, Serge E. Hallyn wrote:
> Namespaced file capabilities were introduced in 8db6c34f1dbc .
> When userspace reads an xattr for a namespaced capability, a
> virtualized representation of it is returned if the caller is
> in a user namespace owned by the capability's owning rootid.
> The function which performs this virtualization was not hooked
> up if CONFIG_SECURITY=n.  Therefore in that case the original
> xattr was shown instead of the virtualized one.
>
> To test this using libcap-bin (*1),
>
> $ v=$(mktemp)
> $ unshare -Ur setcap cap_sys_admin-eip $v
> $ unshare -Ur setcap -v cap_sys_admin-eip $v
> /tmp/tmp.lSiIFRvt8Y: OK
>
> "setcap -v" verifies the values instead of setting them, and
> will check whether the rootid value is set.  Therefore, with
> this bug un-fixed, and with CONFIG_SECURITY=n, setcap -v will
> fail:
>
> $ v=$(mktemp)
> $ unshare -Ur setcap cap_sys_admin=eip $v
> $ unshare -Ur setcap -v cap_sys_admin=eip $v
> nsowner[got=1000, want=0],/tmp/tmp.HHDiOOl9fY differs in []
>
> Fix this bug by calling cap_inode_getsecurity() in
> security_inode_getsecurity() instead of returning
> -EOPNOTSUPP, when CONFIG_SECURITY=n.
>
> *1 - note, if libcap is too old for getcap to have the '-n'
> option, then use verify-caps instead.
>
> Signed-off-by: Serge Hallyn <serge@hallyn.com>
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1593431
> Cc: Hervé Guillemet <herve@guillemet.org>
> Cc: Andrew G. Morgan <morgan@kernel.org>
> Cc: Casey Schaufler <casey@schaufler-ca.com>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  include/linux/security.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/security.h b/include/linux/security.h
> index bc2725491560..39642626a707 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -869,7 +869,7 @@ static inline int security_inode_killpriv(struct dentry *dentry)
>  
>  static inline int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc)
>  {
> -	return -EOPNOTSUPP;
> +	return cap_inode_getsecurity(inode, name, buffer, alloc);
>  }
>  
>  static inline int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags)
